# IT Agent - Setup and Running Instructions

## Backend Setup (Flask + Gemini AI)

### Prerequisites
- Python 3.8+ installed
- Gemini API key (already configured in .env file)

### Setup Steps

#### For Windows:

1. **Navigate to Backend directory:**
   ```powershell
   cd BackEnd
   ```

2. **Create virtual environment (recommended):**
   ```powershell
   python -m venv venv
   venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```powershell
   pip install -r requirements.txt
   ```

4. **Run the Flask server:**
   ```powershell
   python app.py
   ```

#### For macOS/Linux:

1. **Navigate to Backend directory:**
   ```bash
   cd BackEnd
   ```

2. **Create virtual environment (recommended):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the Flask server:**
   ```bash
   python app.py
   ```

The backend server will start on `http://localhost:5000`

## Frontend Setup (Flutter)

### Prerequisites
- Flutter SDK installed and configured
- For Windows: Android Studio or VS Code with Flutter extensions
- For macOS: Xcode (for iOS development) and/or Android Studio, VS Code with Flutter extensions

### Setup Steps

#### For Windows:

1. **Navigate to Frontend directory:**
   ```powershell
   cd FrontEnd
   ```

2. **Get Flutter dependencies:**
   ```powershell
   flutter pub get
   ```

3. **Run the Flutter app:**
   ```powershell
   flutter run -d windows
   ```
   
   Or for web:
   ```powershell
   flutter run -d chrome
   ```

#### For macOS:

1. **Navigate to Frontend directory:**
   ```bash
   cd FrontEnd
   ```

2. **Get Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the Flutter app:**
   ```bash
   # For macOS desktop app
   flutter run -d macos
   
   # For web browser
   flutter run -d chrome
   
   # For iOS simulator (if Xcode is installed)
   flutter run -d ios
   ```

#### For Linux:

1. **Navigate to Frontend directory:**
   ```bash
   cd FrontEnd
   ```

2. **Get Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the Flutter app:**
   ```bash
   # For Linux desktop app
   flutter run -d linux
   
   # For web browser
   flutter run -d chrome
   ```

## Features

### Backend Features
- RESTful API endpoint `/api/chat` for chat interactions
- Health check endpoint `/api/health` for connectivity testing
- CORS enabled for Flutter app communication
- Enhanced Gemini AI prompts for IT assistant context
- Error handling and logging

### Frontend Features
- Modern Flutter UI with Material Design
- Real-time chat interface with the AI
- Connection status indicator
- Loading states and error handling
- Responsive design
- Quick suggestion chips for common IT tasks

## API Endpoints

### POST `/api/chat`
Send a message to the AI assistant
```json
{
  "message": "Check my internet connectivity"
}
```

Response:
```json
{
  "response": "I can help you check your internet connectivity. Here are some steps...",
  "status": "success"
}
```

### GET `/api/health`
Check server health and connectivity
```json
{
  "status": "healthy",
  "message": "Backend server is running",
  "gemini_configured": true
}
```

## Troubleshooting

### Common Issues

1. **Backend not starting:**
   - **Windows/macOS/Linux**: Check if Python is installed and accessible
   - **macOS**: Use `python3` instead of `python` if you get command not found
   - **All platforms**: Ensure all requirements are installed
   - **All platforms**: Verify the Gemini API key in `.env` file

2. **Flutter app can't connect:**
   - Make sure the backend is running on port 5000
   - Check the connection status indicator in the app
   - Try the "Retry" button if disconnected
   - **macOS**: Ensure firewall isn't blocking localhost connections

3. **CORS errors:**
   - The backend is configured to allow all origins
   - If issues persist, check browser console for specific errors

4. **macOS-specific issues:**
   - **Python not found**: Install Python 3 via Homebrew: `brew install python3`
   - **Flutter not found**: Install Flutter via: `brew install --cask flutter`
   - **Xcode required**: For iOS development, install Xcode from App Store
   - **Permission issues**: Use `sudo` only if necessary, prefer user-level installations
   - **macOS desktop support**: Enable with `flutter config --enable-macos-desktop`

5. **Linux-specific issues:**
   - **Desktop app**: Ensure Linux desktop development is enabled: `flutter config --enable-linux-desktop`
   - **Dependencies**: Install required libraries: `sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev`

6. **Network/Connection issues:**
   - **Firewall blocking**: Check if firewall is blocking localhost:5000
   - **Port in use**: Kill existing processes: `lsof -ti:5000 | xargs kill -9` (macOS/Linux)
   - **API timeout**: The app will retry automatically or use the retry button

### Platform-Specific Commands

#### Check Flutter Configuration:
```bash
# All platforms
flutter doctor

# Enable platform support if needed
flutter config --enable-macos-desktop    # macOS
flutter config --enable-linux-desktop    # Linux
flutter config --enable-windows-desktop  # Windows
```

#### Check Python Version:
```bash
# Windows
python --version

# macOS/Linux
python3 --version
```

## Setup Verification

### Before Running the App

#### For macOS:
```bash
chmod +x verify_setup_macos.sh
./verify_setup_macos.sh
```

#### Manual Verification (All Platforms):
```bash
# Check Python
python3 --version  # or python --version on Windows

# Check Flutter
flutter doctor
flutter devices

# Test backend API (after starting backend)
curl http://localhost:5000/api/health
```

## Quick Start Scripts

### Windows
Run the provided batch file:
```powershell
.\start_app.bat
```

### macOS/Linux
Make the script executable and run it:
```bash
chmod +x start_app.sh
./start_app.sh
```

These scripts will automatically:
- Check for required dependencies
- Create virtual environments if needed
- Install Python dependencies
- Start the backend server
- Install Flutter dependencies
- Launch the Flutter app for your platform

## Development Notes

- The backend uses Gemini 1.5 Flash for fast responses
- Flutter app automatically checks server connectivity
- Error messages are displayed in the chat interface
- The system prompt is optimized for IT assistance tasks
