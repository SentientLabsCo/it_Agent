# IT Agent - Setup and Running Instructions

## Backend Setup (Flask + Gemini AI)

### Prerequisites
- Python 3.8+ installed
- Gemini API key (already configured in .env file)

### Setup Steps

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

The backend server will start on `http://localhost:5000`

## Frontend Setup (Flutter)

### Prerequisites
- Flutter SDK installed and configured
- Android Studio or VS Code with Flutter extensions

### Setup Steps

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

1. **Backend not starting:**
   - Check if Python is installed and accessible
   - Ensure all requirements are installed
   - Verify the Gemini API key in `.env` file

2. **Flutter app can't connect:**
   - Make sure the backend is running on port 5000
   - Check the connection status indicator in the app
   - Try the "Retry" button if disconnected

3. **CORS errors:**
   - The backend is configured to allow all origins
   - If issues persist, check browser console for specific errors

## Development Notes

- The backend uses Gemini 1.5 Flash for fast responses
- Flutter app automatically checks server connectivity
- Error messages are displayed in the chat interface
- The system prompt is optimized for IT assistance tasks
