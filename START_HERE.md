# 📦 Snake Game - Web Deployment Package

## 🎯 What You've Got

You now have everything you need to deploy your Raylib Snake game to the web via GitHub Pages!

## 📁 Files Overview

### 🎮 Your Game
- **`snake_game.c`** - Your game code (the only file you really need to edit!)

### 🌐 Web Deployment
- **`index.html`** - Web wrapper for your game
- **`build.sh`** - Script to compile C to WebAssembly  
- **`Makefile`** - Alternative build system (easier!)
- **`.github/workflows/deploy.yml`** - Automatic deployment on GitHub

### 📖 Documentation
- **`README.md`** - Main project documentation
- **`QUICKSTART.md`** - Fast deployment guide
- **`DEPLOYMENT_CHECKLIST.md`** - Step-by-step checklist
- **`FILE_STRUCTURE.md`** - Explains all files
- **`THIS FILE`** - Quick overview

### 🔧 Configuration
- **`.gitignore`** - What Git should ignore
- **`setup.sh`** - Automated setup script

## 🚀 Quick Start (3 Minutes)

### Option 1: Super Quick (Automated)

```bash
# Make setup script executable
chmod +x setup.sh

# Run it!
./setup.sh

# Follow the prompts
```

The script will:
- ✅ Set up Git
- ✅ Update your username in files
- ✅ Configure GitHub remote
- ✅ Commit your files
- ✅ Show you exactly what to do next

### Option 2: Manual (5 Minutes)

1. **Update your info:**
   - Open `README.md` 
   - Replace `yourusername` with your GitHub username (find/replace all)
   - Save

2. **Create GitHub repo:**
   - Go to https://github.com/new
   - Name it `snake-game`
   - Make it Public
   - Don't initialize

3. **Push code:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/snake-game.git
   git branch -M main
   git push -u origin main
   ```

4. **Enable GitHub Pages:**
   - Repository → Settings → Pages
   - Source: **GitHub Actions**

5. **Done!** Visit: `https://YOUR_USERNAME.github.io/snake-game/`

## 🎓 How It Works

```
Your C Code (snake_game.c)
         ↓
    Emscripten Compiler (on GitHub)
         ↓
    WebAssembly (.wasm file)
         ↓
    HTML Page (index.html)
         ↓
    GitHub Pages (free hosting!)
         ↓
    🎮 PLAYABLE IN BROWSER!
```

## 🔨 Building Locally

### Prerequisites
- Emscripten SDK ([installation guide](https://emscripten.org/docs/getting_started/downloads.html))

### Build Commands

**Using Make (recommended):**
```bash
make           # Build for web
make native    # Build for desktop
make serve     # Test in browser
make clean     # Clean build files
```

**Using build script:**
```bash
chmod +x build.sh
./build.sh
python3 -m http.server 8000 --directory docs
```

## 🌟 Key Features of This Setup

✅ **Automatic Deployment** - Push code, get website (no manual building!)
✅ **Free Hosting** - GitHub Pages costs $0
✅ **Version Control** - All changes tracked with Git
✅ **Easy Updates** - Edit C code, push, auto-deploys
✅ **Professional** - Proper project structure
✅ **Documented** - Multiple guides included
✅ **Cross-Platform** - Works on Linux, Mac, Windows

## 📝 What Files Do What

| File | You Edit? | Purpose |
|------|-----------|---------|
| `snake_game.c` | ✅ YES | Your game code |
| `index.html` | 🔧 Once | HTML wrapper (customize colors/text) |
| `README.md` | 🔧 Once | Update username, then done |
| `build.sh` | ❌ No | Handles compilation |
| `Makefile` | ❌ No | Build automation |
| `.github/workflows/deploy.yml` | ❌ No | GitHub automation |
| `docs/*` | ❌ No | Auto-generated web files |

## 🎯 Typical Workflow

### Day 1: Setup
```bash
./setup.sh              # Run setup
# Create repo on GitHub
git push -u origin main # Push code
# Enable Pages
# ✅ Game is live!
```

### Day 2+: Adding Features
```bash
# 1. Edit your game
vim snake_game.c        # Add power-ups, new levels, etc.

# 2. Test locally (optional)
make web && make serve

# 3. Deploy
git add snake_game.c
git commit -m "Added power-ups!"
git push

# 4. Wait 2 minutes
# ✅ Changes live!
```

## 🎨 Customization Ideas

### Easy (Edit HTML)
- Change page title
- Change colors
- Add your name/logo
- Update GitHub link

### Medium (Edit C code)
- Add sound effects
- New game modes
- Different difficulty levels
- Power-ups

### Advanced
- Mobile touch controls
- Multiplayer
- Leaderboards
- Particle effects

## 📚 Documentation Guide

**New to deployment?** Start here:
1. `QUICKSTART.md` - Follow this first
2. `DEPLOYMENT_CHECKLIST.md` - Check off each step
3. This file - Quick reference

**Want to understand everything?**
1. `FILE_STRUCTURE.md` - Understand the files
2. `README.md` - Technical details
3. GitHub Actions logs - See build process

**Need help?**
- Check the troubleshooting sections in any guide
- GitHub Actions logs show build errors
- Browser console (F12) shows runtime errors

## ⚡ Power User Tips

### Fast Deploy
```bash
# One-liner to commit and push
git add . && git commit -m "Update" && git push
```

### Watch for Changes
```bash
# Auto-rebuild on file changes (requires entr or fswatch)
ls snake_game.c | entr -r make web
```

### Quick Test
```bash
# Build and serve in one command
make web && make serve
```

### Multiple Branches
```bash
# Experiment without affecting main
git checkout -b experimental
# Edit and test
git checkout main  # Back to main when done
```

## 🔍 Troubleshooting Quick Reference

| Problem | Solution |
|---------|----------|
| 404 Error | Wait 5 min, check Pages enabled |
| Old version showing | Clear cache (Ctrl+Shift+Del) |
| Build fails | Check Actions tab for logs |
| Game won't load | Check browser console (F12) |
| Permission denied | `chmod +x build.sh setup.sh` |

## 📊 Check Your Deployment

```bash
# 1. Check if site is live
curl -I https://YOUR_USERNAME.github.io/snake-game/

# 2. Should return: HTTP/2 200

# 3. Or just visit in browser!
```

## 🎉 Success Indicators

Your deployment is successful when:
- ✅ GitHub Actions workflow completes (green check)
- ✅ Repository Settings → Pages shows your URL
- ✅ Visiting the URL loads your game
- ✅ All game controls work
- ✅ No errors in browser console

## 🆘 Get Help

**Check these first:**
1. GitHub Actions logs (Actions tab)
2. Browser console (F12)
3. Troubleshooting sections in guides

**Still stuck?**
- Create an issue on your GitHub repo
- Check Raylib Discord
- Stack Overflow (tag: raylib, webassembly)

## 🎓 Learning Resources

**Want to learn more?**
- [Raylib Documentation](https://www.raylib.com/)
- [Emscripten Documentation](https://emscripten.org/)
- [WebAssembly Guide](https://webassembly.org/)
- [GitHub Pages Docs](https://docs.github.com/pages)
- [Git Tutorial](https://git-scm.com/docs/gittutorial)

## 🚀 Next Projects

Once you've got this working:
- Create more Raylib games
- Try 3D games with Raylib
- Build a game portfolio
- Share with the community!

## ⭐ Don't Forget

- Star the Raylib repository on GitHub
- Share your game on social media
- Add to your portfolio
- Help others deploy their games!

---

## 📞 Quick Reference Commands

```bash
# Setup
./setup.sh                  # Automated setup

# Building
make web                    # Build for web
make native                 # Build for desktop
make clean                  # Clean builds

# Testing
make serve                  # Run local server
python3 -m http.server 8000 --directory docs

# Git
git add .                   # Stage changes
git commit -m "message"     # Commit
git push                    # Deploy
git status                  # Check status

# Utilities
chmod +x *.sh              # Make scripts executable
```

---

## 🎮 That's It!

You're ready to deploy! Choose your path:
- 🏃 **Fast:** Run `./setup.sh`
- 📋 **Careful:** Follow `DEPLOYMENT_CHECKLIST.md`
- 📚 **Learning:** Read `QUICKSTART.md` first

**Remember:** The goal is to have fun and share your creation! 🚀

**Good luck, and happy game development! 🎉**
