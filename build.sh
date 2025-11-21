#!/bin/bash
# Simple build script for WebAssembly compilation

echo "🎮 Building Snake Game for Web..."

# Check if emcc is available
if ! command -v emcc &> /dev/null; then
    echo "❌ Error: Emscripten not found!"
    echo "Install from: https://emscripten.org/docs/getting_started/downloads.html"
    exit 1
fi

# Create web build directory
mkdir -p docs

# Compile using Raylib from emscripten ports
emcc snake_game.c \
    -o docs/snake_game.html \
    -Os \
    -Wall \
    -I. \
    -L. \
    -s USE_GLFW=3 \
    -s ASYNCIFY \
    -s TOTAL_STACK=128MB \
    -s INITIAL_MEMORY=128MB \
    --shell-file index.html \
    -DPLATFORM_WEB \
    -s ASSERTIONS=1 \
    --preload-file assets@assets 2>/dev/null || echo "No assets folder found, skipping..."

# Alternative: If you have raylib compiled for web
# emcc snake_game.c -o docs/snake_game.html \
#     -I/path/to/raylib/src \
#     -L/path/to/raylib/src \
#     -lraylib \
#     -s USE_GLFW=3 \
#     --shell-file index.html

echo "✅ Build complete!"
echo "📁 Output files in 'docs' folder"
echo ""
echo "To test locally:"
echo "  python3 -m http.server 8000 --directory docs"
echo "  Then open: http://localhost:8000/snake_game.html"
