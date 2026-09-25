# ScreenGrab

Windows screenshot tool — press the **`** (backtick/grave) key, drag to select an area, and a JPG is saved to your Desktop.

Runs continuously: start it once, then take screenshots as many times as you like.

## How it works

1. Double-click `ScreenGrab.bat` (or the Desktop shortcut `ScreenGrab.bat - Shortcut.lnk`).
2. Press the **`** key (the backtick key, normally under the **Esc** key).
3. The screen dims — click and drag to select the area you want.
4. Release the mouse:
   - the selected area is captured
   - saved to your Desktop as `Screenshot_YYYY-MM-DD_HH-MM-SS.jpg` (JPG, quality 95)
   - a beep plays
   - the file path is copied to your clipboard
5. Press **`** again any time for another shot.

Press **Esc** while selecting to cancel. Press **Ctrl+C** in the console window to stop the tool completely.

## Why the backtick key?

The original version used **Print Screen**, but Windows itself already grabs that key and it behaved inconsistently. The backtick key (`) is rarely used, so it does not conflict with anything.

## Where files are saved

Screenshots go to your Windows Desktop. If a Desktop folder cannot be found, the tool falls back to your user home folder and prints the exact path it used.

The launcher always runs from `C:\Users\Public\ScreenGrab` (not from the `\\wsl.localhost\...` path) because Windows CMD cannot change directory into a UNC network path.

## Requirements

- Python 3 on Windows
- `pillow`, `keyboard`, `pyperclip`

The launcher checks for these automatically. To install them manually:

```bash
python -m pip install pillow keyboard pyperclip
```

## Files

| File | Purpose |
|------|---------|
| `screengrab.py` | Main Python script (v2.1) |
| `ScreenGrab.bat` | Double-click launcher for Windows |

## Troubleshooting

**"Python with PIL, tkinter, keyboard not found"**
Install the libraries: `python -m pip install pillow keyboard pyperclip`

**"Access is denied" on the COM/keyboard hook**
Windows sometimes blocks global key hooks. Run the tool as Administrator once, or restart Windows and try again.

**The `** key does nothing**
Make sure the console window still has focus, or click on it once. Also confirm you are pressing the backtick key directly (not with a layout that maps it elsewhere).

**Screenshot is the wrong size / shows the dark overlay**
The capture happens right after you release the mouse. The overlay window is destroyed before the capture, so this should not happen — if it does, try capturing a slightly larger area.

## Version history

| Version | Date | What changed |
|---------|------|--------------|
| **v2.1** | 2026-09-25 | Save as **JPG** (quality 95) instead of PNG — much smaller files |
| **v2.0** | 2026-09-25 | **Continuous loop** — run the `.bat` once, then press `` ` `` anytime instead of restarting each time |
| **v1.3** | 2026-09-25 | Fixed self-copy error in the launcher; added a pause at the end so the window does not close instantly |
| **v1.2** | 2026-09-25 | Fixed UNC path error — launcher now copies to `C:\Users\Public\ScreenGrab`; every step prints an error message instead of failing silently |
| **v1.1** | 2026-09-25 | Switched trigger from **Print Screen** to the **backtick `** key |
| **v1.0** | 2026-09-25 | Initial release — Print Screen trigger, drag-select overlay, PNG saved to Desktop, beep, clipboard copy |
