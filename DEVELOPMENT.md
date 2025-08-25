# Development Guide - Web Application

## 🚀 Quick Start

```bash
# Install dependencies
pnpm install

# Start development server
pnpm dev
```

Access your app at: **http://localhost:7020**

## 📋 Available Scripts

### Development
- `pnpm dev` - Start development server with hot reload
- `pnpm dev:local` - Start development server accessible on network

### Production 
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm preview` - Preview production build locally

### Quality
- `pnpm test` - Run tests
- `pnpm typecheck` - TypeScript validation
- `pnpm format.fix` - Format code with Prettier

## 🌐 Web Development Workflow

1. **Development**: `pnpm dev` → Edit code → See changes instantly
2. **Testing**: `pnpm test` → Verify functionality  
3. **Build**: `pnpm build` → Create production bundle
4. **Deploy**: Use Netlify or Vercel MCP integration

## 🏗️ Architecture

- **Frontend**: React SPA at `client/`
- **Backend**: Express API at `server/`
- **Shared**: Common types at `shared/`

## 🎯 Focus Areas

This application is **web-first** and optimized for:
- Modern browsers
- Cloud deployment
- Mobile responsiveness  
- Progressive enhancement

---

**No desktop or executable versions - pure web application!**
