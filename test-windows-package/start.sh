#!/bin/bash

echo "=========================================="
echo "    Transaction Manager - Test Package"
echo "=========================================="
echo ""
echo "🚀 Starting Transaction Manager..."
echo "🌐 Will be available at: http://localhost:3000"
echo "🛑 Press Ctrl+C to stop"
echo ""
echo "✨ Starting server..."
echo ""

# Start the production server
cd "$(dirname "$0")"
node dist/server/production.mjs
