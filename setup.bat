@echo off
REM Setup script for Windows users

echo ====================================
echo Snake Game - Windows Setup
echo ====================================
echo.

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git is not installed!
    echo Please install Git from: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo [OK] Git is installed
echo.

REM Get GitHub username
set /p GITHUB_USER="Enter your GitHub username: "
if "%GITHUB_USER%"=="" (
    echo [ERROR] GitHub username cannot be empty!
    pause
    exit /b 1
)

REM Get repository name
set /p REPO_NAME="Enter repository name (default: snake-game): "
if "%REPO_NAME%"=="" set REPO_NAME=snake-game

echo.
echo Configuration:
echo   GitHub User: %GITHUB_USER%
echo   Repository: %REPO_NAME%
echo   URL: https://github.com/%GITHUB_USER%/%REPO_NAME%
echo   Live URL: https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo.
set /p CONFIRM="Is this correct? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo Setup cancelled
    pause
    exit /b 1
)

REM Initialize Git repository if needed
if not exist .git (
    echo.
    echo Initializing Git repository...
    git init
    echo [OK] Git repository initialized
) else (
    echo [OK] Already in a Git repository
)

REM Update README.md
echo.
echo Updating README.md...
if exist README.md (
    powershell -Command "(Get-Content README.md) -replace 'yourusername', '%GITHUB_USER%' -replace 'snake-game', '%REPO_NAME%' | Set-Content README.md"
    echo [OK] README.md updated
)

REM Update index.html
echo Updating index.html...
if exist index.html (
    powershell -Command "(Get-Content index.html) -replace 'yourusername', '%GITHUB_USER%' -replace 'snake-game', '%REPO_NAME%' | Set-Content index.html"
    echo [OK] index.html updated
)

REM Set up Git remote
echo.
echo Setting up Git remote...
set REMOTE_URL=https://github.com/%GITHUB_USER%/%REPO_NAME%.git

git remote get-url origin >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [WARNING] Remote 'origin' already exists
    set /p UPDATE_REMOTE="Do you want to update it? (Y/N): "
    if /i "%UPDATE_REMOTE%"=="Y" (
        git remote set-url origin %REMOTE_URL%
        echo [OK] Remote updated
    )
) else (
    git remote add origin %REMOTE_URL%
    echo [OK] Remote added
)

REM Add and commit files
echo.
echo Preparing initial commit...
git add .
git diff --staged --quiet
if %ERRORLEVEL% NEQ 0 (
    git commit -m "Initial commit: Snake Game setup"
    echo [OK] Files committed
) else (
    echo [WARNING] No changes to commit
)

REM Display next steps
echo.
echo ====================================
echo [SUCCESS] Setup Complete!
echo ====================================
echo.
echo Next Steps:
echo.
echo 1. Create the repository on GitHub:
echo    - Go to: https://github.com/new
echo    - Repository name: %REPO_NAME%
echo    - Make it Public
echo    - Don't initialize with README
echo.
echo 2. Push your code:
echo    git branch -M main
echo    git push -u origin main
echo.
echo 3. Enable GitHub Pages:
echo    - Repository -^> Settings -^> Pages
echo    - Source: GitHub Actions
echo.
echo 4. Wait 2-3 minutes, then visit:
echo    https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo.
echo ====================================
echo.

REM Offer to open GitHub
set /p OPEN_BROWSER="Would you like to open GitHub in your browser now? (Y/N): "
if /i "%OPEN_BROWSER%"=="Y" (
    start https://github.com/new
)

echo.
echo For detailed instructions, see:
echo   - QUICKSTART.md
echo   - DEPLOYMENT_CHECKLIST.md
echo   - START_HERE.md
echo.
echo Happy coding!
echo.
pause
