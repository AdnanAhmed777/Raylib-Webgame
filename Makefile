# Makefile for Snake Game

# Compiler and flags
CC = gcc
EMCC = emcc
CFLAGS = -Wall -Wextra -O2
RAYLIB_FLAGS = -lraylib -lm

# Emscripten flags
EM_FLAGS = -Os -Wall -DPLATFORM_WEB
EM_FLAGS += -s USE_GLFW=3
EM_FLAGS += -s ASYNCIFY
EM_FLAGS += -s TOTAL_STACK=128MB
EM_FLAGS += -s INITIAL_MEMORY=128MB
EM_FLAGS += -s ALLOW_MEMORY_GROWTH=1
EM_FLAGS += -s FULL_ES2=1
EM_FLAGS += -s EXPORTED_FUNCTIONS='["_main"]'
EM_FLAGS += -s EXPORTED_RUNTIME_METHODS='["ccall"]'

# Source files
SRC = snake_game.c
OUT_NATIVE = snake_game
OUT_WEB = docs/index.html
SHELL_FILE = index.html

# Detect OS
ifeq ($(OS),Windows_NT)
    PLATFORM = Windows
    RAYLIB_FLAGS += -lopengl32 -lgdi32 -lwinmm
    OUT_NATIVE = snake_game.exe
    RM = del /Q
    MKDIR = if not exist docs mkdir docs
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        PLATFORM = Linux
        RAYLIB_FLAGS += -lpthread -ldl -lrt -lX11
    endif
    ifeq ($(UNAME_S),Darwin)
        PLATFORM = Mac
        RAYLIB_FLAGS += -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL
    endif
    RM = rm -f
    MKDIR = mkdir -p docs
endif

.PHONY: all web native clean help run serve

# Default target
all: web

# Build for web
web:
	@echo "🎮 Building Snake Game for Web ($(PLATFORM))..."
	@$(MKDIR)
	$(EMCC) $(SRC) -o $(OUT_WEB) $(EM_FLAGS) --shell-file $(SHELL_FILE)
	@echo "✅ Web build complete! Files in 'docs' folder"

# Build native executable
native:
	@echo "🎮 Building Snake Game for Native ($(PLATFORM))..."
	$(CC) $(SRC) -o $(OUT_NATIVE) $(CFLAGS) $(RAYLIB_FLAGS)
	@echo "✅ Native build complete! Executable: $(OUT_NATIVE)"

# Run native executable
run: native
	./$(OUT_NATIVE)

# Start local web server
serve:
	@echo "🌐 Starting local server at http://localhost:8000"
	@echo "Press Ctrl+C to stop"
	@cd docs && python3 -m http.server 8000

# Clean build files
clean:
	@echo "🧹 Cleaning build files..."
	$(RM) $(OUT_NATIVE)
	$(RM) -r docs
	@echo "✅ Clean complete!"

# Help message
help:
	@echo "Snake Game - Makefile Commands"
	@echo "==============================="
	@echo "make         - Build web version (default)"
	@echo "make web     - Build WebAssembly version"
	@echo "make native  - Build native executable"
	@echo "make run     - Build and run native version"
	@echo "make serve   - Start local web server"
	@echo "make clean   - Remove build files"
	@echo "make help    - Show this help message"
	@echo ""
	@echo "Platform detected: $(PLATFORM)"
