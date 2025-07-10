# macOS Setup Guide for IT Agent

## Prerequisites Installation

### 1. Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Python 3
```bash
brew install python3
```

### 3. Install Flutter
```bash
brew install --cask flutter
```

### 4. Install Xcode (for iOS development - optional)
Download from App Store or:
```bash
xcode-select --install
```

## Setup Steps

### 1. Enable Flutter Desktop Support
```bash
flutter config --enable-macos-desktop
```

### 2. Check Flutter Setup
```bash
flutter doctor
```

### 3. Navigate to Project Directory
```bash
cd /path/to/your/it_Agent
```

### 4. Quick Start
```bash
chmod +x start_app.sh
./start_app.sh
```

## Common macOS Issues & Solutions

### Issue: "python: command not found"
**Solution:** Use `python3` instead of `python`
```bash
# In the backend directory
python3 -m venv venv
```

### Issue: "flutter: command not found"
**Solution:** Add Flutter to your PATH
```bash
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### Issue: "No supported devices connected"
**Solution:** Enable macOS desktop support
```bash
flutter config --enable-macos-desktop
flutter devices
```

### Issue: Xcode errors for iOS
**Solution:** Accept Xcode license and install additional components
```bash
sudo xcodebuild -license accept
sudo xcode-select --install
```

### Issue: Permission denied when running scripts
**Solution:** Make scripts executable
```bash
chmod +x start_app.sh
```

### Issue: Backend port already in use
**Solution:** Kill existing processes on port 5000
```bash
lsof -ti:5000 | xargs kill -9
```

### Issue: Flutter build fails on macOS
**Solution:** Update Xcode and accept licenses
```bash
sudo xcodebuild -license accept
flutter doctor --android-licenses
```

## Manual Setup (if script fails)

### Backend:
```bash
cd BackEnd
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

### Frontend (in new terminal):
```bash
cd FrontEnd
flutter pub get
flutter run -d macos
```

## Testing the Setup

### 1. Test Backend API
```bash
curl http://localhost:5000/api/health
```

### 2. Test Chat Endpoint
```bash
curl -X POST http://localhost:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello, test message"}'
```

### 3. Check Flutter Devices
```bash
flutter devices
```

## Environment Variables

Make sure the `.env` file in the BackEnd directory contains:
```
GEMINI_API_KEY=your_api_key_here
```

## Useful Commands

### Stop all related processes:
```bash
# Find and kill Python processes
pkill -f "python.*app.py"

# Find and kill Flutter processes
pkill -f flutter
```

### View logs:
```bash
# Backend logs (if running in background)
tail -f nohup.out

# Flutter logs
flutter logs
```

### Clean Flutter cache:
```bash
flutter clean
flutter pub get
```
