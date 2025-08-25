#!/bin/bash

echo "=========================================="
echo "     Transaction Manager - Local Setup"
echo "=========================================="
echo
echo "Welcome! Setting up your local transaction manager..."
echo "This will automatically install everything you need."
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}ERROR: Node.js is not installed or not in PATH${NC}"
    echo "Please install Node.js from https://nodejs.org/"
    echo
    read -p "Press Enter to exit..."
    exit 1
fi

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    echo -e "${YELLOW}PNPM not found. Installing PNPM...${NC}"
    npm install -g pnpm
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: Failed to install PNPM${NC}"
        echo "You may need to run with sudo: sudo npm install -g pnpm"
        read -p "Press Enter to exit..."
        exit 1
    fi
fi

echo -e "${GREEN}Node.js version:${NC}"
node --version
echo
echo -e "${GREEN}PNPM version:${NC}"
pnpm --version
echo

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    echo "This may take a few minutes on first run..."
    pnpm install
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: Failed to install dependencies${NC}"
        read -p "Press Enter to exit..."
        exit 1
    fi
    echo
    echo -e "${GREEN}Dependencies installed successfully!${NC}"
    echo
fi

echo "=========================================="
echo -e "${GREEN}       STARTING TRANSACTION MANAGER${NC}"
echo "=========================================="
echo
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo -e "${GREEN}✅ Server starting on: http://localhost:7020${NC}"
echo -e "${GREEN}✅ Browser will open automatically${NC}"
echo
echo -e "${YELLOW}📝 To add transactions: Press 'A' key${NC}"
echo -e "${YELLOW}💾 To backup data: Go to 'Backup' tab${NC}"
echo -e "${YELLOW}🛑 To stop: Press Ctrl+C in this terminal${NC}"
echo
echo "=========================================="
echo

# Function to open browser based on OS
open_browser() {
    local url="http://localhost:7020"

    # Detect OS and open browser
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        open "$url"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v xdg-open &> /dev/null; then
            xdg-open "$url"
        elif command -v gnome-open &> /dev/null; then
            gnome-open "$url"
        fi
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
        # Windows (Git Bash, Cygwin, MSYS)
        start "$url"
    fi
}

# Start browser opener in background
(sleep 3 && open_browser) &

# Start the development server
echo -e "${BLUE}🚀 Starting development server...${NC}"
echo
echo "Opening browser in 3 seconds..."
echo

# Start browser opener in background
(
    sleep 3
    open_browser
) &

echo -e "${GREEN}✨ Transaction Manager is starting...${NC}"
echo
pnpm dev

# If pnpm dev fails, show error
if [ $? -ne 0 ]; then
    echo
    echo -e "${RED}ERROR: Failed to start the development server${NC}"
    echo "Please check the error messages above"
    read -p "Press Enter to exit..."
fi
