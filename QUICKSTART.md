# 🚀 Quick Start Guide - Deploy to GitHub Pages

Follow these steps to get your Snake Game live on the web in minutes!

## Prerequisites Check

✅ Make sure you have:
- A GitHub account
- Git installed on your computer
- Emscripten SDK installed (for local building)

## 🎯 Method 1: Automatic Deployment (Easiest)

### Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com/new)
2. Create a new repository named `snake-game`
3. Make it **Public**
4. **Don't** initialize with README (we already have one)

### Step 2: Upload Your Files

```bash
# Navigate to your project folder
cd /path/to/your/snake-game

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Raylib Snake Game"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/snake-game.git

# Push to GitHub
git push -u origin main
```

### Step 3: Enable GitHub Actions

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Click **Pages** in the left sidebar
4. Under **Source**, select **GitHub Actions**
5. That's it! ✨

### Step 4: Wait for Deployment

1. Go to the **Actions** tab in your repository
2. You'll see a workflow running (green dot or yellow circle)
3. Wait for it to complete (usually 2-3 minutes)
4. Once complete, your game will be live at:
   ```
   https://YOUR_USERNAME.github.io/snake-game/
   ```

## 🎯 Method 2: Manual Building and Deployment

### Step 1: Install Emscripten

```bash
# Clone emsdk
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk

# Install latest
./emsdk install latest
./emsdk activate latest

# Activate for current terminal
source ./emsdk_env.sh
```

### Step 2: Build Locally

```bash
# Go back to your project
cd /path/to/your/snake-game

# Make build script executable
chmod +x build.sh

# Build the game
./build.sh

# Or use Make
make web
```

### Step 3: Test Locally

```bash
# Start local server
python3 -m http.server 8000 --directory docs

# Open in browser: http://localhost:8000
```

### Step 4: Deploy to GitHub

```bash
# Add and commit the docs folder
git add docs
git commit -m "Build web version"
git push origin main
```

### Step 5: Configure GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Under **Source**, select **Deploy from a branch**
3. Select **main** branch
4. Select **/docs** folder
5. Click **Save**
6. Wait 1-2 minutes, then visit:
   ```
   https://YOUR_USERNAME.github.io/snake-game/
   ```

## 🐛 Troubleshooting

### "emcc: command not found"

**Solution:**
```bash
# Activate Emscripten in current terminal
cd /path/to/emsdk
source ./emsdk_env.sh
cd /path/to/your/snake-game
```

### GitHub Actions Failing

**Check these:**
1. Is the `.github/workflows/deploy.yml` file in the right location?
2. Go to **Settings** → **Pages** → Select "GitHub Actions" as source
3. Check the **Actions** tab for error messages

### Game Not Loading in Browser

**Solutions:**
- Clear your browser cache (Ctrl+Shift+Delete)
- Check browser console (F12) for errors
- Try a different browser
- Make sure all three files exist in docs: `.html`, `.js`, `.wasm`

### Permission Denied on build.sh

**Solution:**
```bash
chmod +x build.sh
./build.sh
```

## 📝 Customization

### Change Game Title

Edit `index.html`:
```html
<title>Your Game Name</title>
<h1>🎮 Your Game Name</h1>
```

### Update GitHub Link

Edit `index.html`:
```html
<a href="https://github.com/YOUR_USERNAME/snake-game" class="github-link">
```

### Modify README

Update `README.md` with:
- Your GitHub username
- Your repository name
- Your game URL

## 🎉 You're Done!

Your game should now be live! Share it with:
- Friends and family
- Social media
- Your portfolio
- Game development communities

## 📚 Next Steps

- Add your game to your portfolio
- Submit to game showcases
- Add new features (see README.md for ideas)
- Create more games!

## 💡 Tips

1. **Custom Domain:** You can add a custom domain in GitHub Pages settings
2. **Analytics:** Add Google Analytics to track visitors
3. **SEO:** Update meta tags in index.html for better search visibility
4. **Mobile:** Test on mobile devices - arrow keys can be mapped to touch controls

---

**Need Help?** Open an issue on GitHub or check the troubleshooting section.

**Made something cool?** Share it! Tag it with #RaylibGame #WebAssembly
