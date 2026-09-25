@echo off
REM ScreenGrab v1.2 — simple launcher, shows every step
setlocal

echo.
echo --- ScreenGrab ---

REM Always use a local Windows folder to avoid UNC errors
set "LOCAL_DIR=C:\Users\Public\ScreenGrab"
if not exist "%LOCAL_DIR%" (
    echo Creating folder: %LOCAL_DIR%
    mkdir "%LOCAL_DIR%"
)

echo Copying files to %LOCAL_DIR% ...
copy /Y "%~dp0screengrab.py" "%LOCAL_DIR%\" 
if errorlevel 1 echo ERROR: Could not copy screengrab.py

copy /Y "%~dp0ScreenGrab.bat" "%LOCAL_DIR%\" 
if errorlevel 1 echo ERROR: Could not copy ScreenGrab.bat

echo.
echo Running from: %LOCAL_DIR%
pushd "%LOCAL_DIR%" >nul || (
    echo ERROR: Cannot enter %LOCAL_DIR%
    pause
    goto end
)

echo Checking Python libraries...
pythonw -c "import PIL, tkinter, keyboard" 2>nul
if %errorlevel%==0 (
    echo Using Windows Python (pythonw)
    pythonw screengrab.py
    goto end
)

python3 -c "import PIL, tkinter, keyboard" 2>nul
if %errorlevel%==0 (
    echo Using Python3
    python3 screengrab.py
    goto end
)

echo.
echo ERROR: Python with PIL, tkinter, keyboard not found.
echo Please install: python -m pip install pillow keyboard pyperclip
pause

:end
echo.
echo Done. Press any key to close this window.
pause >nul
popd
endlocal
