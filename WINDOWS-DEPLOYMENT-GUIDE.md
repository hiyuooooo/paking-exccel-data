# 🚀 Transaction Manager - Windows Deployment Guide

## Overview

This guide covers two deployment scenarios:

1. **Development Mode** - For developers and source code users
2. **Packaged Executable** - For end-users (standalone Windows app)

---

## 🎯 Option 1: Quick Start (Packaged Executable)

### For End Users - No Technical Setup Required

If you have the **packaged version** (`windows-package.zip`):

1. **Extract** the downloaded zip file to any folder
2. **Double-click** `start-app.bat`
3. **Wait** for the browser to open automatically
4. **Start using** the Transaction Manager!

### What's Included in the Package

```
windows-package/
├── transaction-manager.exe     # Main application (no Node.js needed)
├── start-app.bat              # One-click launcher
├── run.bat                    # Alternative launcher with more options
├── dist/spa/                  # Web application files
├── README.txt                 # Quick instructions
└── INSTALLATION-GUIDE.md      # Detailed guide
```

### System Requirements

- **Windows 10** or **Windows 11**
- **Web Browser** (Chrome, Firefox, Edge - any modern browser)
- **No additional software needed**

---

## 🔧 Option 2: Development Setup (Source Code)

### For Developers and Advanced Users

#### Prerequisites

1. **Node.js v16+** - Download from [nodejs.org](https://nodejs.org/)
2. **Git** (optional) - For cloning the repository

#### Quick Setup

1. **Download/Clone** the source code
2. **Double-click** `run.bat` in the project folder
3. **Wait** for automatic installation and startup
4. **Browser opens** automatically at `http://localhost:7020`

#### Manual Setup

```bash
# Install dependencies
pnpm install
# or
npm install

# Start development server
pnpm dev
# or
npm run dev
```

---

## 🏗️ Creating Your Own Windows Executable

### For Developers: Building Distribution Package

#### Step 1: Prepare Environment

```bash
# Ensure Node.js 16+ is installed
node --version

# Install global tools
npm install -g pkg pnpm
```

#### Step 2: Build Executable (Automated)

```bash
# Run the automated build script
./build-windows.bat
```

This will:

- Install all dependencies
- Build the client application
- Build the server application
- Create `transaction-manager.exe`
- Package everything in `windows-package/` folder

#### Step 3: Manual Build (Alternative)

```bash
# Build client and server
pnpm run build

# Create Windows executable
pnpm run build:windows

# Or build for all platforms
pnpm run build:all
```

#### Step 4: Package for Distribution

```bash
# Run packaging script
pnpm run package:windows
```

---

## 📁 Directory Structure Explained

### Development Structure

```
transaction-manager/
├── client/                    # React frontend source
│   ├── components/           # UI components
│   ├── pages/               # Route pages
│   └── lib/                 # Utilities
├── server/                   # Express backend source
│   ├── routes/              # API endpoints
│   └── index.ts             # Server setup
├── shared/                   # Shared TypeScript types
├── dist/                    # Built files (after build)
│   ├── spa/                 # Built frontend
│   └── server/              # Built backend
├── run.bat                  # Development launcher
├── build-windows.bat        # Build script
└── package.json             # Dependencies & scripts
```

### Distribution Structure

```
windows-package/
├── transaction-manager.exe   # Standalone Node.js app
├── start-app.bat            # Simple launcher
├── dist/spa/                # Web UI files
└── README.txt               # User instructions
```

---

## 🎮 Usage Instructions

### Starting the Application

#### Development Mode

- **Quick:** Double-click `run.bat`
- **Manual:** `pnpm dev` in terminal
- **URL:** `http://localhost:7020`

#### Packaged Mode

- **Quick:** Double-click `start-app.bat` in package folder
- **Manual:** Run `transaction-manager.exe` in terminal
- **URL:** `http://localhost:3000`

### Application Features

#### Core Functions

- ✅ **Transaction Management** - Add, edit, delete transactions
- ✅ **Customer Database** - Manage customer information
- ✅ **Data Import** - PDF bank statements, Excel files
- ✅ **Data Export** - JSON, Excel formats
- ✅ **Monthly Reports** - Summaries and analytics
- ✅ **Auto Backup** - Saves data every 5 minutes

#### Keyboard Shortcuts

- **A** - Add new transaction (when not editing)
- **Enter** - Save changes (when editing)
- **Escape** - Cancel editing
- **Ctrl+C** - Stop server (in command window)

---

## 🔧 Configuration Options

### Port Configuration

#### Development Mode

Edit `vite.config.ts`:

```typescript
server: {
  port: 7020,  // Change this number
}
```

#### Production Mode

Set environment variable:

```bash
set PORT=8080
transaction-manager.exe
```

### Environment Variables

- **PORT** - Server port (default: 3000 in production, 7020 in dev)
- **NODE_ENV** - Environment mode
- **PING_MESSAGE** - Custom API message

---

## 🛠️ Troubleshooting

### Common Issues

#### "Port already in use"

**Problem:** Another application is using the port

**Solutions:**

1. Close other applications using the port
2. Change port in configuration
3. Restart computer to free all ports

#### "Node.js not found" (Development only)

**Problem:** Node.js not installed or not in PATH

**Solutions:**

1. Install Node.js from [nodejs.org](https://nodejs.org/)
2. Restart command prompt
3. Verify with `node --version`

#### "Dependencies failed to install"

**Problem:** Network or permission issues

**Solutions:**

1. Check internet connection
2. Run as Administrator
3. Clear npm cache: `npm cache clean --force`
4. Delete `node_modules` and try again

#### "Browser doesn't open automatically"

**Problem:** Default browser not set or blocked

**Solutions:**

1. Manually open browser to `http://localhost:7020` (dev) or `http://localhost:3000` (prod)
2. Set default browser in Windows settings
3. Check if antivirus is blocking

#### "Application won't start"

**Problem:** Various startup issues

**Solutions:**

1. Check Windows Event Viewer for errors
2. Run in Command Prompt to see error messages
3. Verify all files are present in package
4. Try running as Administrator

### Debug Mode

#### Development Debug

```bash
# Run with verbose logging
pnpm dev --debug

# Type checking
pnpm typecheck

# Run tests
pnpm test
```

#### Production Debug

```bash
# Run executable with console output
transaction-manager.exe

# Check if files are accessible
dir dist\spa
```

---

## 📊 Performance & Limits

### System Requirements

- **RAM:** 4GB minimum, 8GB recommended
- **Disk:** 100MB for application, 1GB for data
- **CPU:** Any modern processor (2GHz+)
- **Network:** Not required (fully offline)

### Data Limits

- **Transactions:** Browser-dependent (typically 50,000+)
- **Customers:** No hard limit
- **File uploads:** 50MB maximum
- **Backup files:** Usually under 10MB

### Performance Tips

1. **Regular backups** - Export data weekly
2. **Browser cache** - Clear monthly for best performance
3. **Close unused tabs** - Frees memory
4. **Restart weekly** - Keeps performance optimal

---

## 🔒 Security & Privacy

### Data Security

- **Local storage only** - No data sent to external servers
- **Browser encryption** - Data encrypted by browser
- **No tracking** - Application doesn't collect usage data
- **Offline capable** - No internet required after setup

### Backup Security

- **Export control** - You control all data exports
- **Local files** - Backups saved to your computer only
- **Standard formats** - JSON and Excel for transparency

---

## 🚀 Distribution Guide

### For Software Distributors

#### Creating Distribution Package

1. Run `build-windows.bat`
2. Test the `windows-package/` folder
3. Zip the entire `windows-package/` folder
4. Distribute the zip file

#### Package Contents Verification

```
✅ transaction-manager.exe (8-15MB)
✅ start-app.bat (< 1KB)
✅ dist/spa/ folder (2-5MB)
✅ README.txt (< 5KB)
```

#### Installation Instructions for Users

1. Download and extract zip file
2. Double-click `start-app.bat`
3. Browser opens automatically
4. Start using the application

### Virus Scanner Notes

- **Executable files** may trigger antivirus warnings
- **False positives** are common with packaged Node.js apps
- **Whitelist** the application folder if needed
- **Source code** is available for security review

---

## 📞 Support & Maintenance

### Self-Diagnostics

1. **Check browser console** (F12) for error messages
2. **Verify file integrity** - Ensure all files are present
3. **Test with different browser** - Rule out browser issues
4. **Restart application** - Often resolves temporary issues

### Update Process

1. **Export data** before updating
2. **Replace application files** with new version
3. **Keep existing data** (stored in browser)
4. **Import data** if needed

### Maintenance Schedule

- **Weekly:** Export backup data
- **Monthly:** Clear browser cache
- **Quarterly:** Update to latest version

---

## 📋 Quick Reference

### Development Commands

```bash
pnpm install           # Install dependencies
pnpm dev              # Start development server
pnpm build            # Build for production
pnpm build:windows    # Create Windows executable
pnpm package:windows  # Create distribution package
```

### File Locations

- **Development:** `http://localhost:7020`
- **Production:** `http://localhost:3000`
- **Data:** Browser localStorage
- **Backups:** Downloads folder (when exported)

### Key Files

- **`run.bat`** - Development launcher
- **`start-app.bat`** - Production launcher (in package)
- **`transaction-manager.exe`** - Standalone application
- **`LOCAL_DEPLOYMENT.md`** - Detailed technical guide

---

_🎉 Your Transaction Manager is now ready for Windows deployment! Whether running in development mode or as a packaged executable, you have complete control over your financial data with no external dependencies._
