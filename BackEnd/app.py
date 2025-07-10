from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import google.generativeai as genai
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Configure CORS to allow requests from Flutter app
CORS(app, origins=["*"], methods=["GET", "POST", "OPTIONS"], 
     allow_headers=["Content-Type", "Authorization"])

# Configure Gemini API
GEMINI_API_KEY = os.getenv('GEMINI_API_KEY')
if not GEMINI_API_KEY:
    raise ValueError("GEMINI_API_KEY environment variable is required")

genai.configure(api_key=GEMINI_API_KEY)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint for Flutter app to test connectivity"""
    return jsonify({
        'status': 'healthy',
        'message': 'Backend server is running',
        'gemini_configured': bool(GEMINI_API_KEY)
    })

@app.route('/api/chat', methods=['POST', 'OPTIONS'])
def chat():
    # Handle preflight OPTIONS request
    if request.method == 'OPTIONS':
        return jsonify({'status': 'ok'}), 200
        
    try:
        data = request.json
        message = data.get('message')
        
        if not message:
            return jsonify({'error': 'Message is required'}), 400
        
        # Enhanced system prompt for IT assistant context
        system_prompt = """You are an IT Assistant AI designed to help with technical support and IT-related questions. 
        You can help with:
        - Network connectivity issues
        - System health checks
        - Software troubleshooting
        - Hardware diagnostics
        - Security concerns
        - Browser and cache issues
        - Printer problems
        - General IT support
        
        Provide clear, helpful, and actionable responses. If you need more information to help, ask specific questions."""
        
        # Updated model name - use one of these:
        # gemini-1.5-flash (recommended for speed)
        # gemini-1.5-pro (for more complex tasks)
        # gemini-2.0-flash (latest model)
        model = genai.GenerativeModel('gemini-1.5-flash')
        
        # Create full prompt with context
        full_prompt = f"{system_prompt}\n\nUser: {message}\n\nAssistant:"
        
        # Generate response
        response = model.generate_content(full_prompt)
        
        return jsonify({
            'response': response.text,
            'status': 'success'
        })
        
    except Exception as e:
        print(f"Error in chat endpoint: {str(e)}")
        return jsonify({
            'error': str(e),
            'status': 'error'
        }), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)