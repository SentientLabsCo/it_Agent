#!/bin/bash

echo "Starting IT Agent Backend and Frontend..."
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed or not in PATH"
    echo "Install Python 3 using: brew install python3 (macOS) or your package manager (Linux)"
    exit 1
fi

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "Error: Flutter is not installed or not in PATH"
    echo "Install Flutter using: brew install --cask flutter (macOS) or download from flutter.dev"
    exit 1
fi

echo "Starting Backend Server..."
cd "$SCRIPT_DIR/BackEnd"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment and install dependencies
source venv/bin/activate
pip install -r requirements.txt

# Start backend in background
echo "Backend server starting at http://localhost:5000"
python app.py &
BACKEND_PID=$!

# Wait a moment for backend to start
sleep 3

echo "Starting Frontend..."
cd "$SCRIPT_DIR/FrontEnd"

# Get Flutter dependencies
flutter pub get

# Detect platform and run appropriate version
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Running Flutter app for macOS..."
    flutter run -d macos &
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    echo "Running Flutter app for Linux..."
    flutter run -d linux &
else
    # Fallback to web
    echo "Running Flutter app in browser..."
    flutter run -d chrome &
fi

FRONTEND_PID=$!

echo ""
echo "Both services are starting..."
echo "Backend: http://localhost:5000"
echo "Frontend: Native desktop app"
echo ""
echo "Press Ctrl+C to stop both services"

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Stopping services..."
    kill $BACKEND_PID 2>/dev/null
    kill $FRONTEND_PID 2>/dev/null
    echo "Services stopped."
    exit 0
}

# Trap Ctrl+C and cleanup
trap cleanup SIGINT

# Wait for either process to finish
wait
