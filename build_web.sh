#!/bin/bash

# Build script for compiling Raylib C game to WebAssembly

echo "Building Snake Game for Web..."

# Check if emcc is available
if ! command -v emcc &> /dev/null
then
    echo "Error: Emscripten (emcc) not found!"
    echo "Please install Emscripten: https://emscripten.org/docs/getting_started/downloads.html"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p web_build

# Compile the game
emcc snake_game.c \
    -o web_build/snake_game.js \
    -Os \
    -Wall \
    -DPLATFORM_WEB \
    -s USE_GLFW=3 \
    -s ASYNCIFY \
    -s TOTAL_MEMORY=67108864 \
    -s FORCE_FILESYSTEM=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    --shell-file index.html \
    -DPLATFORM_WEB \
    -s ASSERTIONS=1 \
    -s WASM=1 \
    -s ASYNCIFY \
    --preload-file assets \
    -I/path/to/raylib/src \
    /path/to/raylib/src/libraylib.a

# Note: You need to update the paths above to point to your Raylib installation
# Or use raylib from emscripten ports:

emcc snake_game.c \
    -o web_build/snake_game.js \
    -Os \
    -Wall \
    -DPLATFORM_WEB \
    -s USE_GLFW=3 \
    -s ASYNCIFY \
    -s TOTAL_MEMORY=67108864 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s WASM=1 \
    --shell-file index.html \
    -s USE_GLFW=3 \
    -s FULL_ES3=1 \
    -s EXPORTED_FUNCTIONS='["_main"]' \
    -s EXPORTED_RUNTIME_METHODS='["ccall"]'

echo "Build complete! Files are in web_build/"
echo "To test locally, run: python3 -m http.server 8000 --directory web_build"
echo "Then open: http://localhost:8000"
