@echo off
REM ScreenGrab launcher — runs the drag-select screenshot tool
REM Requires: python3 + pillow + tkinter + keyboard library

REM Try Windows Python first, then WSL python3
where pythonw >nul 2>&1 (
    pythonw -c "import PIL, tkinter, keyboard" 2>nul && (
        echo Using Windows Python...
        pythonw "%~dp0screengrab.py"
        goto end
    )
)

REM Fall back to WSL python3
python3 -c "import PIL, tkinter, keyboard" 2>nul && (
    echo Using WSL Python...
    python3 "%~dp0screengrab.py"
    goto end
)

echo ERROR: Python with PIL, tkinter, and keyboard library is required.
echo Run: python -m pip install pillow keyboard pyperclip
pause

:end
