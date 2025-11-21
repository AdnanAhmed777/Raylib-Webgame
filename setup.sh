#!/bin/bash

# Automated Setup Script for Snake Game Deployment
# This script will help you set up your repository for GitHub Pages

set -e  # Exit on error

echo "🐍 Snake Game - Automated Setup"
echo "================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed!${NC}"
    echo "Please install Git first: https://git-scm.com/downloads"
    exit 1
fi

echo -e "${GREEN}✅ Git is installed${NC}"

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo ""
    echo "📁 Initializing Git repository..."
    git init
    echo -e "${GREEN}✅ Git repository initialized${NC}"
else
    echo -e "${GREEN}✅ Already in a Git repository${NC}"
fi

# Get GitHub username
echo ""
echo "📝 Let's configure your project"
echo "-------------------------------"
read -p "Enter your GitHub username: " GITHUB_USER

if [ -z "$GITHUB_USER" ]; then
    echo -e "${RED}❌ GitHub username cannot be empty!${NC}"
    exit 1
fi

# Get repository name
read -p "Enter repository name (default: snake-game): " REPO_NAME
REPO_NAME=${REPO_NAME:-snake-game}

echo ""
echo -e "${YELLOW}Configuration:${NC}"
echo "  GitHub User: $GITHUB_USER"
echo "  Repository: $REPO_NAME"
echo "  URL: https://github.com/$GITHUB_USER/$REPO_NAME"
echo "  Live URL: https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
read -p "Is this correct? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${RED}Setup cancelled${NC}"
    exit 1
fi

# Update README.md
echo ""
echo "📝 Updating README.md with your details..."
if [ -f README.md ]; then
    sed -i.bak "s/yourusername/$GITHUB_USER/g" README.md
    sed -i.bak "s/snake-game/$REPO_NAME/g" README.md
    rm -f README.md.bak
    echo -e "${GREEN}✅ README.md updated${NC}"
fi

# Update index.html
echo "📝 Updating index.html..."
if [ -f index.html ]; then
    sed -i.bak "s/yourusername/$GITHUB_USER/g" index.html
    sed -i.bak "s/snake-game/$REPO_NAME/g" index.html
    rm -f index.html.bak
    echo -e "${GREEN}✅ index.html updated${NC}"
fi

# Check if emscripten is installed
echo ""
echo "🔍 Checking for Emscripten..."
if command -v emcc &> /dev/null; then
    echo -e "${GREEN}✅ Emscripten is installed${NC}"
    
    # Offer to build
    read -p "Would you like to build the web version now? (y/n): " BUILD_NOW
    if [ "$BUILD_NOW" = "y" ] || [ "$BUILD_NOW" = "Y" ]; then
        echo ""
        echo "🔨 Building web version..."
        if [ -f build.sh ]; then
            chmod +x build.sh
            ./build.sh
        elif [ -f Makefile ]; then
            make web
        else
            echo -e "${YELLOW}⚠️  No build script found${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠️  Emscripten not found${NC}"
    echo "You'll need to install Emscripten for local building"
    echo "Or let GitHub Actions build it automatically"
    echo ""
    echo "Install from: https://emscripten.org/docs/getting_started/downloads.html"
fi

# Set up git remote
echo ""
echo "🔗 Setting up Git remote..."
REMOTE_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"

if git remote get-url origin &> /dev/null; then
    echo -e "${YELLOW}⚠️  Remote 'origin' already exists${NC}"
    read -p "Do you want to update it to $REMOTE_URL? (y/n): " UPDATE_REMOTE
    if [ "$UPDATE_REMOTE" = "y" ] || [ "$UPDATE_REMOTE" = "Y" ]; then
        git remote set-url origin $REMOTE_URL
        echo -e "${GREEN}✅ Remote updated${NC}"
    fi
else
    git remote add origin $REMOTE_URL
    echo -e "${GREEN}✅ Remote added${NC}"
fi

# Add and commit files
echo ""
echo "📦 Preparing initial commit..."

git add .

if git diff --staged --quiet; then
    echo -e "${YELLOW}⚠️  No changes to commit${NC}"
else
    git commit -m "Initial commit: Snake Game setup"
    echo -e "${GREEN}✅ Files committed${NC}"
fi

# Display next steps
echo ""
echo "================================"
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo "================================"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1️⃣  Create the repository on GitHub:"
echo "   👉 Go to: https://github.com/new"
echo "   📝 Repository name: $REPO_NAME"
echo "   🔓 Make it Public"
echo "   ❌ Don't initialize with README"
echo ""
echo "2️⃣  Push your code:"
echo "   Run: git branch -M main"
echo "   Run: git push -u origin main"
echo ""
echo "3️⃣  Enable GitHub Pages:"
echo "   👉 Repository → Settings → Pages"
echo "   📝 Source: GitHub Actions"
echo ""
echo "4️⃣  Wait 2-3 minutes, then visit:"
echo "   🌐 https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
echo "================================"
echo ""

# Offer to open GitHub
read -p "Would you like to open GitHub in your browser now? (y/n): " OPEN_BROWSER
if [ "$OPEN_BROWSER" = "y" ] || [ "$OPEN_BROWSER" = "Y" ]; then
    if command -v xdg-open &> /dev/null; then
        xdg-open "https://github.com/new" &
    elif command -v open &> /dev/null; then
        open "https://github.com/new" &
    elif command -v start &> /dev/null; then
        start "https://github.com/new" &
    else
        echo "Please open this URL manually: https://github.com/new"
    fi
fi

echo ""
echo "📚 For detailed instructions, see:"
echo "   - QUICKSTART.md"
echo "   - DEPLOYMENT_CHECKLIST.md"
echo ""
echo -e "${GREEN}Happy coding! 🎮${NC}"
