# 🐍 Raylib Snake Game - Web Version

A classic Snake game built with Raylib C library and compiled to WebAssembly for web browsers.

[**🎮 Play the Game**](https://AdnanAhmed777.github.io/Raylib-Webgame/)

## Features

- ✨ Smooth gameplay with increasing difficulty
- 🎯 Score tracking and high score system
- 👀 Animated snake with directional eyes
- 🎨 Clean, modern UI with grid display
- ⚡ Progressive speed increase as you score
- 🌐 Runs in any modern web browser

## Controls

- **Arrow Keys** - Move the snake (Up, Down, Left, Right)
- **Space/Enter** - Start game or restart after game over
- **ESC** - Return to menu from game over screen

## Local Development

### Prerequisites

- [Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html)
- C compiler (GCC or Clang)
- Python 3 (for local testing)

### Setup Emscripten

```bash
# Clone emsdk
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk

# Install and activate latest SDK
./emsdk install latest
./emsdk activate latest

# Activate PATH (do this every time you open a new terminal)
source ./emsdk_env.sh
```

### Building for Web

1. Clone this repository:
```bash
git clone https://github.com/AdnanAhmed777/Raylib-Webgame.git
cd Raylib-Webgame
```

2. Build the game:
```bash
chmod +x build.sh
./build.sh
```

3. Test locally:
```bash
python3 -m http.server 8000 --directory docs
```

4. Open your browser to: `http://localhost:8000`

### Building for Desktop (Optional)

If you have Raylib installed locally:

```bash
# Linux/Mac
gcc snake_game.c -o snake_game -lraylib -lm -lpthread -ldl -lrt -lX11

# Windows (MinGW)
gcc snake_game.c -o snake_game.exe -lraylib -lopengl32 -lgdi32 -lwinmm

# Run
./snake_game
```

## Deploying to GitHub Pages

### Option 1: Automatic Deployment (Recommended)

This project includes GitHub Actions for automatic deployment.

1. **Enable GitHub Pages:**
   - Go to your repository Settings
   - Navigate to "Pages" in the left sidebar
   - Under "Source", select "GitHub Actions"

2. **Push your code:**
```bash
git add .
git commit -m "Initial commit"
git push origin main
```

3. **Wait for deployment:**
   - GitHub Actions will automatically build and deploy
   - Check the "Actions" tab to see progress
   - Your game will be live at: `https://AdnanAhmed777.github.io/Raylib-Webgame/`

### Option 2: Manual Deployment

1. Build the game locally:
```bash
./build.sh
```

2. Commit the `docs` folder:
```bash
git add docs
git commit -m "Build web version"
git push origin main
```

3. Enable GitHub Pages:
   - Go to repository Settings → Pages
   - Set source to "Deploy from a branch"
   - Select `main` branch and `/docs` folder
   - Click Save

## Project Structure

```
Raylib-Webgame/
├── snake_game.c           # Main game source code
├── index.html             # HTML shell for WebAssembly
├── build.sh               # Build script for web
├── .github/
│   └── workflows/
│       └── deploy.yml     # GitHub Actions workflow
├── docs/                  # Built web files (generated)
│   ├── index.html
│   ├── snake_game.js
│   ├── snake_game.wasm
│   └── snake_game.data
└── README.md
```

## Game Mechanics

- **Starting Length:** 3 segments
- **Grid Size:** 40x22.5 cells (1600x900 pixels)
- **Initial Speed:** 0.15s per move
- **Speed Increase:** Gets faster with each point scored
- **Max Speed:** 0.05s per move
- **Wall Collision:** Game over
- **Self Collision:** Game over

## Technical Details

- **Language:** C
- **Graphics Library:** Raylib
- **Web Compilation:** Emscripten
- **Target:** WebAssembly (WASM)
- **Browser Requirements:** Any modern browser with WebAssembly support

## Troubleshooting

### Build Errors

**"emcc: command not found"**
- Make sure Emscripten is installed and activated
- Run `source /path/to/emsdk/emsdk_env.sh`

**"Raylib not found"**
- The build script uses Raylib from Emscripten ports
- Make sure you're using the latest Emscripten version

### Deployment Issues

**GitHub Actions fails:**
- Check the Actions tab for error logs
- Ensure `deploy.yml` is in `.github/workflows/`
- Verify GitHub Pages is enabled in repository settings

**Game doesn't load:**
- Clear browser cache
- Check browser console for errors
- Ensure all three files are present: `.html`, `.js`, `.wasm`

## Credits

- **Game Engine:** [Raylib](https://www.raylib.com/)
- **Developer:** Abdul Musawwer & Hunzala Ahmed
- **Inspiration:** Classic Snake game

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests

## Future Enhancements

- [ ] Add sound effects
- [ ] Add background music
- [ ] Add multiple difficulty levels
- [ ] Add power-ups
- [ ] Add leaderboard system
- [ ] Mobile touch controls
- [ ] Add obstacles/mazes

---

**Enjoy the game! 🐍**

If you like this project, please give it a ⭐ on GitHub!
