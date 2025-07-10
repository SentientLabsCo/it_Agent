@echo off
echo Starting IT Agent Backend and Frontend...
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH
    pause
    exit /b 1
)

REM Check if Flutter is available
flutter --version >nul 2>&1
if errorlevel 1 (
    echo Error: Flutter is not installed or not in PATH
    pause
    exit /b 1
)

echo Starting Backend Server...
cd /d "%~dp0BackEnd"

REM Install Python dependencies if needed
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

call venv\Scripts\activate
pip install -r requirements.txt

REM Start backend in new window
start "IT Agent Backend" cmd /k "venv\Scripts\activate && python app.py"

echo Backend started. Waiting 3 seconds before starting frontend...
timeout /t 3 /nobreak >nul

echo Starting Frontend...
cd /d "%~dp0FrontEnd"

REM Get Flutter dependencies
flutter pub get

REM Start frontend
start "IT Agent Frontend" cmd /k "flutter run -d windows"

echo.
echo Both services are starting...
echo Backend: http://localhost:5000
echo Frontend: Will open automatically
echo.
pause
