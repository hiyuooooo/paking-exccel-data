# Transaction Manager Web App

A simple, standalone web application for managing financial transactions with local server support.

## 🚀 Quick Start

### Method 1: Auto Server Setup (Recommended)
```
Double-click: start-webapp.bat
```
This will:
- Check for Node.js installation
- Install local server if needed
- Start the web server
- Open the app in your browser at http://localhost:8080/webapp/

### Method 2: Direct Browser (No Server)
```
Open: webapp/index.html directly in your browser
```
Note: Some features may be limited without a local server.

## 📋 Features

### 💰 Transaction Management
- Add deposits and withdrawals
- Customer name tracking
- Transaction details and notes
- Real-time balance calculation

### 📊 Dashboard
- Total transactions count
- Total transaction amount
- Current balance with color coding
- Recent transactions table

### 🛠️ Additional Features
- **Keyboard Shortcuts**: Press 'A' to quickly add transaction, 'Esc' to clear form
- **Data Export**: Export all transactions as JSON
- **Local Storage**: Data persists between sessions
- **Sample Data**: Run `addSampleData()` in console for demo data
- **Responsive Design**: Works on mobile and desktop

### 🔧 Server Controls
- Test server connectivity
- Export transaction data
- Clear all data
- Refresh application

## 🎮 Usage

1. **Add Transaction**: Fill in customer name, amount, type (deposit/withdrawal), and details
2. **View Stats**: Dashboard shows real-time statistics
3. **Manage Data**: Use server controls to export or clear data
4. **Quick Actions**: Use keyboard shortcuts for faster input

## 🌐 Server Requirements

**Automatic Setup**: The `start-webapp.bat` handles everything automatically.

**Manual Setup**:
- Node.js (optional, for local server features)
- Any HTTP server (http-server, serve, or built-in browser file:// protocol)

## 📱 Browser Compatibility

- Chrome/Chromium ✅
- Firefox ✅  
- Safari ✅
- Edge ✅

## 💾 Data Storage

- Uses browser localStorage for data persistence
- Data survives browser restarts
- Export feature creates JSON backup files

## 🎨 Design

- Modern glass-morphism design
- Responsive mobile-friendly layout
- Professional color scheme
- Smooth animations and transitions

## 🔒 Security

- Client-side only (no server data storage)
- Data stays on your local machine
- No external dependencies or tracking

---

**Created with ❤️ for simple transaction management**
