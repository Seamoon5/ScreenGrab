# ScreenGrab

Windows screenshot tool — hold **Print Screen**, drag to select area, save PNG to Desktop.

## How it works

1. Run `ScreenGrab.bat` (or `python screengrab.py`).
2. Press the **Print Screen** key.
3. Click and drag to select the area you want.
4. Release — screenshot saved to your Desktop as `Screenshot_YYYY-MM-DD_HH-MM-SS.png`.
5. A beep plays and the file path is copied to clipboard.

## Requirements

- Python 3 (Windows or WSL)
- `pillow`, `keyboard`, `pyperclip` (installed automatically by launcher if available)

Install manually if needed:
```bash
python -m pip install pillow keyboard pyperclip
```

## Files

- `screengrab.py` — main Python script
- `ScreenGrab.bat` — double-click launcher for Windows

## Version history

- **v1.0 (2026-09-25)** — Initial release: Print Screen trigger, drag-select overlay, PNG save to Desktop, beep notification, clipboard copy.
