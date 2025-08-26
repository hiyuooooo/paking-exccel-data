const express = require('express');
const path = require('path');

const app = express();
const port = 3001; // Use different port to avoid conflicts

// Serve static files from dist/spa
const distPath = path.join(__dirname, 'dist', 'spa');
console.log(`📂 Serving static files from: ${distPath}`);

app.use(express.static(distPath, {
  index: false,
  setHeaders: (res, filePath) => {
    if (filePath.endsWith('.js')) {
      res.setHeader('Content-Type', 'application/javascript');
    } else if (filePath.endsWith('.css')) {
      res.setHeader('Content-Type', 'text/css');
    }
  }
}));

// Health check endpoint
app.get('/api/ping', (req, res) => {
  res.json({ message: 'Server is running', timestamp: new Date() });
});

// Serve index.html for all non-API routes (React Router)
app.get('*', (req, res) => {
  if (req.path.startsWith('/api/')) {
    return res.status(404).json({ error: 'API endpoint not found' });
  }
  
  const indexPath = path.join(distPath, 'index.html');
  console.log(`📄 Serving index.html from: ${indexPath}`);
  res.sendFile(indexPath);
});

app.listen(port, () => {
  console.log(`🚀 Test Production Server running!`);
  console.log(`📱 Frontend: http://localhost:${port}`);
  console.log(`🔧 API Test: http://localhost:${port}/api/ping`);
  console.log(`📂 Static files: ${distPath}`);
});
