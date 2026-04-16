@echo off
:: Helper script to sync assets submodule with private repository
:: Usage: sync-assets.bat [push|pull]

echo ========================================
echo Portfolio Assets Sync Tool
echo ========================================
echo.

if "%~1"=="push" goto push
if "%~1"=="pull" goto pull
goto usage

:push
    echo Pushing assets to private repository...
    cd assets
    git add .
    git commit -m "Update assets" 2>nul || echo No changes to commit
    git push origin main
    cd ..
    echo.
    echo Updating submodule reference in main repo...
    git add assets
    git commit -m "Update assets submodule" 2>nul || echo No submodule changes to commit
    git push origin main
    echo.
    echo Done! Assets pushed and submodule reference updated.
    goto end

:pull
    echo Pulling latest assets from private repository...
    git pull origin main
    git submodule update --init --recursive
    echo.
    echo Done! Assets updated.
    goto end

:usage
    echo Usage: sync-assets.bat [push^|pull]
    echo.
    echo   push  - Commit and push assets to private repo, update submodule reference
    echo   pull  - Pull latest changes including assets submodule
    echo.
    echo Examples:
    echo   sync-assets.bat push
    echo   sync-assets.bat pull

:end
    echo.
