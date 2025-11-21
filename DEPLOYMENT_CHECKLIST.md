# ✅ Deployment Checklist

Use this checklist to deploy your Snake Game to GitHub Pages step-by-step.

## 📋 Pre-Deployment Checklist

- [ ] You have a GitHub account
- [ ] Git is installed on your computer
- [ ] You have all project files in one folder
- [ ] You've tested the game locally (optional but recommended)

## 🚀 Step-by-Step Deployment

### ✅ Step 1: Prepare Your Repository

```bash
# 1. Navigate to your project folder
cd /path/to/your/snake-game

# 2. Initialize git repository (if not already done)
git init

# 3. Add all files
git add .

# 4. Create first commit
git commit -m "Initial commit: Snake Game"
```

**Verify:**
```bash
git status  # Should say "nothing to commit, working tree clean"
```

---

### ✅ Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. Fill in:
   - **Repository name:** `snake-game` (or your preferred name)
   - **Description:** "Classic Snake game built with Raylib and WebAssembly"
   - **Visibility:** Public (required for free GitHub Pages)
   - **Initialize:** Leave all checkboxes UNCHECKED
3. Click **Create repository**

**Don't close this page yet!** You'll need the URL.

---

### ✅ Step 3: Connect Local to GitHub

GitHub will show you commands. Use these:

```bash
# Add GitHub as remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/snake-game.git

# Push your code
git branch -M main
git push -u origin main
```

**Verify:** Refresh your GitHub repository page - you should see all your files!

---

### ✅ Step 4: Enable GitHub Pages

**Option A: GitHub Actions (Recommended - Automatic)**

1. In your repository, click **Settings** (top right)
2. Scroll down and click **Pages** (left sidebar)
3. Under **Source**, select **GitHub Actions**
4. You're done! GitHub will automatically build and deploy

**Option B: Deploy from Branch (Manual)**

1. In repository Settings → Pages
2. Under **Source**, select **Deploy from a branch**
3. Branch: **main**
4. Folder: **/docs**
5. Click **Save**

---

### ✅ Step 5: Wait for Deployment

**If using GitHub Actions:**
1. Go to **Actions** tab
2. You'll see a workflow running
3. Click on it to see progress
4. Wait 2-3 minutes until it shows ✅ green checkmark

**If using manual deployment:**
1. Wait 1-2 minutes
2. GitHub will process your files

---

### ✅ Step 6: Access Your Game

Your game is now live at:
```
https://YOUR_USERNAME.github.io/snake-game/
```

**Important:** Replace `YOUR_USERNAME` with your actual GitHub username!

**Example:** If your username is `john123`:
```
https://john123.github.io/snake-game/
```

---

## 🔧 Customization Checklist

Before sharing your game, customize these:

### Update README.md

- [ ] Replace `yourusername` with your GitHub username (multiple places)
- [ ] Replace `Abdul Musawwer & Hunzala Ahmed` with your name
- [ ] Update the live game link
- [ ] Add your own description

**Find and replace in README.md:**
```bash
# Replace all instances
yourusername → YOUR_USERNAME
```

### Update index.html

- [ ] Update the GitHub link in the corner
- [ ] Change the page title if desired
- [ ] Customize colors/styling (optional)

**In index.html, line ~92:**
```html
<a href="https://github.com/YOUR_USERNAME/snake-game" class="github-link">
```

### Update GitHub Repository

- [ ] Add a description to your repository
- [ ] Add topics/tags: `game`, `raylib`, `webassembly`, `snake`, `c`
- [ ] Create a nice repository description

---

## 🧪 Testing Checklist

Test your deployed game:

- [ ] Game loads without errors
- [ ] Arrow keys work correctly
- [ ] Space/Enter starts the game
- [ ] Snake moves smoothly
- [ ] Collision detection works
- [ ] Score increments correctly
- [ ] Game over screen appears
- [ ] High score saves
- [ ] Can restart the game
- [ ] Works on mobile (arrows might not work, but should load)

**Test on multiple browsers:**
- [ ] Chrome/Edge
- [ ] Firefox
- [ ] Safari (if on Mac)

---

## 📱 Mobile Optimization (Optional)

If you want mobile support, add touch controls:

### Add to snake_game.c:
```c
// In the input handling section
Vector2 touch = GetTouchPosition(0);
if (IsGestureDetected(GESTURE_SWIPE_RIGHT)) {
    snake.nextDirection = (Position){1, 0};
}
// ... similar for other directions
```

### Rebuild:
```bash
make web
git add docs
git commit -m "Add mobile controls"
git push
```

---

## 🐛 Troubleshooting

### ❌ Game not loading

**Check:**
1. Open browser console (F12)
2. Look for errors
3. Check all three files exist: `.html`, `.js`, `.wasm`
4. Clear cache and try again (Ctrl+Shift+Delete)

**Solution:**
```bash
# Rebuild locally
make clean
make web

# Or trigger GitHub Actions
git commit --allow-empty -m "Trigger rebuild"
git push
```

### ❌ GitHub Actions failing

**Check:**
1. Go to Actions tab
2. Click on the failed workflow
3. Read the error message
4. Common fixes:
   - Ensure `deploy.yml` is in `.github/workflows/`
   - Check file syntax (YAML is indent-sensitive)
   - Verify GitHub Pages is enabled

### ❌ 404 Error

**Possible causes:**
1. GitHub Pages not enabled
2. Wrong URL (check your username)
3. Repository name mismatch
4. Need to wait a few more minutes

**Solution:**
- Double-check Settings → Pages is enabled
- Verify the URL format
- Wait 5 minutes and try again

### ❌ Old version showing

**Solution:**
1. Clear browser cache
2. Hard refresh (Ctrl+Shift+R or Cmd+Shift+R)
3. Try incognito/private window
4. Wait for CDN to update (can take 10-15 minutes)

---

## 🎉 Success Checklist

You've successfully deployed if:

- [✅] Your game loads at your GitHub Pages URL
- [✅] You can play the game in browser
- [✅] All controls work
- [✅] Game over and restart function
- [✅] No console errors

---

## 📢 Sharing Your Game

Now that it's live, share it!

### Update Your Repository

Add a link in your repository README:
```markdown
🎮 [Play the Game](https://YOUR_USERNAME.github.io/snake-game/)
```

### Share On:

- [ ] Twitter/X with hashtags: #RaylibGame #WebAssembly #GameDev
- [ ] Reddit: r/gamedev, r/WebAssembly, r/raylib
- [ ] Discord game dev servers
- [ ] LinkedIn (great for portfolio!)
- [ ] Your portfolio website
- [ ] With friends and family!

### Add to Portfolio

Include in your portfolio:
```markdown
### Snake Game (WebAssembly)
Classic snake game built with C and Raylib, compiled to WebAssembly.
[Play](https://username.github.io/snake-game/) | [Source](https://github.com/username/snake-game)

**Tech:** C, Raylib, WebAssembly, Emscripten, GitHub Pages
```

---

## 🔄 Making Updates

After deployment, to add new features:

```bash
# 1. Edit your code
vim snake_game.c

# 2. Test locally (optional)
make web
make serve

# 3. Commit and push
git add snake_game.c
git commit -m "Add new feature: power-ups"
git push

# 4. Wait 2-3 minutes
# 5. Game automatically updates!
```

---

## 📊 Analytics (Optional)

Want to know how many people play your game?

### Add Google Analytics:

1. Create a Google Analytics account
2. Get your tracking ID
3. Add to `index.html` before `</head>`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=YOUR_TRACKING_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'YOUR_TRACKING_ID');
</script>
```

---

## 🎯 Next Steps

- [ ] Add more features (power-ups, levels, etc.)
- [ ] Create more games!
- [ ] Learn more about Raylib
- [ ] Experiment with WebAssembly
- [ ] Build a game portfolio

---

## 💡 Pro Tips

1. **Version Control:** Make frequent commits
   ```bash
   git add .
   git commit -m "Descriptive message"
   git push
   ```

2. **Backup:** GitHub is your backup! Push regularly

3. **Documentation:** Update README as you add features

4. **Testing:** Test before pushing (but if it breaks, just fix and push again!)

5. **Learning:** Check GitHub Actions logs to understand the build process

---

## 🆘 Need Help?

- **Check the error logs:** GitHub Actions tab
- **Browser console:** F12 for errors
- **GitHub Issues:** Create an issue in your repo
- **Raylib Discord:** Great community for help
- **Stack Overflow:** Tag your questions with `raylib`, `webassembly`

---

## ✅ Final Verification

Before considering the deployment complete:

```bash
# Check your game is live
curl -I https://YOUR_USERNAME.github.io/snake-game/

# Should return: HTTP/2 200
```

Or simply open the URL in your browser and play! 🎮

---

**Congratulations! Your game is now live on the internet! 🎉**

Share your creation and inspire others to build games too!
