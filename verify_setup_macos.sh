#!/bin/bash

echo "🍎 IT Agent - macOS Setup Verification"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if all checks pass
ALL_GOOD=true

# Function to print status
print_status() {
    if [ $2 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${RED}✗${NC} $1"
        ALL_GOOD=false
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check Python 3
echo "Checking Python 3..."
python3 --version > /dev/null 2>&1
print_status "Python 3 installed" $?

if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
    echo "   Version: $PYTHON_VERSION"
fi

# Check pip
echo ""
echo "Checking pip..."
python3 -m pip --version > /dev/null 2>&1
print_status "pip available" $?

# Check Flutter
echo ""
echo "Checking Flutter..."
flutter --version > /dev/null 2>&1
print_status "Flutter installed" $?

if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version 2>&1 | head -n1 | cut -d' ' -f2)
    echo "   Version: $FLUTTER_VERSION"
fi

# Check Flutter doctor
echo ""
echo "Running Flutter doctor..."
flutter doctor > /dev/null 2>&1
print_status "Flutter doctor passed" $?

# Check macOS desktop support
echo ""
echo "Checking Flutter macOS support..."
flutter config --enable-macos-desktop > /dev/null 2>&1
flutter devices | grep -q "macOS"
print_status "macOS desktop support enabled" $?

# Check if backend directory exists
echo ""
echo "Checking project structure..."
if [ -d "BackEnd" ]; then
    print_status "BackEnd directory found" 0
    
    if [ -f "BackEnd/app.py" ]; then
        print_status "app.py found" 0
    else
        print_status "app.py found" 1
    fi
    
    if [ -f "BackEnd/requirements.txt" ]; then
        print_status "requirements.txt found" 0
    else
        print_status "requirements.txt found" 1
    fi
    
    if [ -f "BackEnd/.env" ]; then
        print_status ".env file found" 0
    else
        print_status ".env file found" 1
        print_warning "You'll need to create a .env file with your GEMINI_API_KEY"
    fi
else
    print_status "BackEnd directory found" 1
fi

# Check if frontend directory exists
if [ -d "FrontEnd" ]; then
    print_status "FrontEnd directory found" 0
    
    if [ -f "FrontEnd/pubspec.yaml" ]; then
        print_status "pubspec.yaml found" 0
    else
        print_status "pubspec.yaml found" 1
    fi
else
    print_status "FrontEnd directory found" 1
fi

# Check if ports are available
echo ""
echo "Checking port availability..."
if ! lsof -i :5000 > /dev/null 2>&1; then
    print_status "Port 5000 available" 0
else
    print_status "Port 5000 available" 1
    print_warning "Port 5000 is in use. Stop other services or change the port."
fi

echo ""
echo "======================================"

if [ "$ALL_GOOD" = true ]; then
    echo -e "${GREEN}🎉 All checks passed! You're ready to run the IT Agent.${NC}"
    echo ""
    echo "To start the application:"
    echo "   chmod +x start_app.sh"
    echo "   ./start_app.sh"
else
    echo -e "${RED}❌ Some issues found. Please resolve them before running the application.${NC}"
    echo ""
    echo "Common fixes:"
    echo "   • Install Python 3: brew install python3"
    echo "   • Install Flutter: brew install --cask flutter"
    echo "   • Enable macOS support: flutter config --enable-macos-desktop"
    echo "   • Accept Xcode license: sudo xcodebuild -license accept"
fi

echo ""
