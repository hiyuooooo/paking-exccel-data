# Transaction Manager - Web Application

A modern React-based transaction management system designed for web deployment.

## 🌐 Web Application Features

- **Frontend**: React 18 + TypeScript + Vite
- **Backend**: Express API server
- **Styling**: TailwindCSS + Radix UI components
- **Routing**: React Router 6 SPA mode
- **Testing**: Vitest

## 🚀 Development

```bash
# Install dependencies
pnpm install

# Start development server
pnpm dev
# Opens at http://localhost:7020
```

## 🏗️ Production Build

```bash
# Build for production
pnpm build

# Start production server
pnpm start
# Serves at http://localhost:3000
```

## 🌍 Deployment Options

### Netlify (Recommended)
- Connect to [Netlify MCP](#open-mcp-popover)
- Automatic builds from git repository
- CDN and hosting included

### Vercel
- Connect to [Vercel MCP](#open-mcp-popover)  
- Zero-config deployment
- Automatic previews

### Manual Deployment
1. Run `pnpm build`
2. Deploy `dist/spa/` folder to any static hosting
3. Deploy `dist/server/` to Node.js hosting for API

## 📁 Project Structure

```
client/               # React frontend
├── pages/            # Route components
├── components/       # Reusable components  
├── lib/             # Utilities
└── App.tsx          # Main app with routing

server/              # Express API
├── routes/          # API endpoints
└── index.ts         # Server setup

shared/              # Shared types
└── api.ts           # API interfaces
```

## 🔧 API Endpoints

- `GET /api/ping` - Health check
- `GET /api/demo` - Demo endpoint

## 🎯 Web-Only Features

- Single Page Application (SPA)
- Responsive design for all devices
- Modern web standards
- Progressive enhancement
- SEO-friendly routing

## 📱 Browser Support

- Chrome/Chromium ✅
- Firefox ✅
- Safari ✅  
- Edge ✅

---

**This is a web-first application optimized for modern browsers and cloud deployment.**
