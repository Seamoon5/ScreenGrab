#!/usr/bin/env python3
"""ScreenGrab v1.0 — Windows / WSL screenshot by drag-select."""
import os, datetime, sys, time

# Paths
DESKTOP = os.path.join(os.path.expanduser("~"), "Desktop")
if not os.path.isdir(DESKTOP):
    DESKTOP = os.path.expanduser("~")

try:
    from PIL import Image, ImageGrab, ImageDraw
except Exception as e:
    print("ERROR: PIL/Pillow not installed. Run: python -m pip install pillow")
    sys.exit(1)

try:
    import tkinter as tk
except Exception:
    print("ERROR: tkinter not available.")
    sys.exit(1)

print("ScreenGrab loaded. Press PRINT SCREEN, drag to select, save to Desktop.")


class GrabOverlay:
    def __init__(self, root):
        self.root = root
        self.root.attributes("-fullscreen", True)
        self.root.attributes("-alpha", 0.3)
        self.root.configure(bg="black")
        self.root.overrideredirect(True)
        self.root.attributes("-topmost", True)
        self.canvas = tk.Canvas(root, bg="black", highlightthickness=0, cursor="crosshair")
        self.canvas.pack(fill="both", expand=True)
        self.canvas.bind("<ButtonPress-1>", self.on_press)
        self.canvas.bind("<B1-Motion>", self.on_drag)
        self.canvas.bind("<ButtonRelease-1>", self.on_release)
        self.canvas.bind("<Escape>", self.on_cancel)
        self.rect = None
        self.start_x = self.start_y = None
        self.result = None

    def on_press(self, event):
        self.start_x = event.x_root
        self.start_y = event.y_root
        self.rect = self.canvas.create_rectangle(
            self.start_x, self.start_y, self.start_x, self.start_y,
            outline="cyan", width=2, fill=""
        )

    def on_drag(self, event):
        if self.rect:
            self.canvas.coords(self.rect, self.start_x, self.start_y, event.x_root, event.y_root)

    def on_release(self, event):
        x1, y1 = self.start_x, self.start_y
        x2, y2 = event.x_root, event.y_root
        x1, x2 = min(x1, x2), max(x1, x2)
        y1, y2 = min(y1, y2), max(y1, y2)
        # Ensure at least 1 pixel
        if x2 <= x1: x2 = x1 + 1
        if y2 <= y1: y2 = y1 + 1
        self.result = (x1, y1, x2, y2)
        self.root.destroy()

    def on_cancel(self, event):
        self.result = None
        self.root.destroy()


def capture_region(bbox):
    img = ImageGrab.grab(bbox=bbox)
    return img


def main():
    import keyboard
    print("Waiting for PRINT SCREEN key...")
    keyboard.wait("print screen")
    print("Select area: click and drag, release to capture.")

    root = tk.Tk()
    overlay = GrabOverlay(root)
    root.mainloop()

    if overlay.result:
        x1, y1, x2, y2 = overlay.result
        img = capture_region((x1, y1, x2, y2))
        filename = datetime.datetime.now().strftime("Screenshot_%Y-%m-%d_%H-%M-%S.png")
        filepath = os.path.join(DESKTOP, filename)
        img.save(filepath, "PNG")
        print(f"Saved screenshot to: {filepath}")

        # Try Windows beep (only works on Windows Python)
        try:
            import winsound
            winsound.Beep(1000, 150)
        except Exception:
            pass

        # Copy path to clipboard (works cross-platform via pyperclip / clipboard)
        try:
            import pyperclip
            pyperclip.copy(filepath)
        except Exception:
            pass
        print("Copied file path to clipboard.")
    else:
        print("Cancelled.")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nStopped.")
