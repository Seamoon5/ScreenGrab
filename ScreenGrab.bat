@echo off
REM ScreenGrab launcher — handles UNC (WSL) paths by switching to C:\Users\Public
setlocal

REM Check if we're in a UNC path (like \wsl.localhost\...)
echo Current path: %CD%
if "%CD:~0,2%"=="\\" (
    echo UNC path detected — switching to local folder...
    set "LOCAL_DIR=C:\Users\Public\ScreenGrab"
    if not exist "%LOCAL_DIR%" mkdir "%LOCAL_DIR%"
    copy /Y "%~dp0screengrab.py" "%LOCAL_DIR%\" >nul 2>&1
    copy /Y "%~dp0ScreenGrab.bat" "%LOCAL_DIR%\" >nul 2>&1
    pushd "%LOCAL_DIR%" >nul
    set SCRIPT_DIR=%LOCAL_DIR%
) else (
    set "SCRIPT_DIR=%~dp0"
)

REM Try Windows Python first
where pythonw >nul 2>&1 (
    pythonw -c "import PIL, tkinter, keyboard" 2>nul && (
        echo Using Windows Python...
        pythonw "%SCRIPT_DIR%screengrab.py"
        goto end
    )
)

REM Fall back to WSL python3 (installed in WSL but callable from Windows via wsl)
python3 -c "import PIL, tkinter, keyboard" 2>nul && (
    echo Using WSL Python...
    python3 "%SCRIPT_DIR%screengrab.py"
    goto end
)

echo ERROR: Python with PIL, tkinter, and keyboard library is required.
echo Run: python -m pip install pillow keyboard pyperclip
pause

:end
popd
endlocal
