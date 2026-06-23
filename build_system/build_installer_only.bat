@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Building installer from existing EXE...
echo ========================================
echo.

set "ISCC_PATH=D:\Soft\Inno Setup 6\ISCC.exe"
set "SCRIPT_DIR=%~dp0"

echo Script dir: "%SCRIPT_DIR%"
echo ISCC path: "%ISCC_PATH%"
echo.

if not exist "%SCRIPT_DIR%downloader.exe" (
    echo [ERROR] downloader.exe not found in script directory!
    echo Expected: "%SCRIPT_DIR%downloader.exe"
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%ffmpeg.exe" (
    echo [ERROR] ffmpeg.exe not found in script directory!
    echo Expected: "%SCRIPT_DIR%ffmpeg.exe"
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%ffprobe.exe" (
    echo [ERROR] ffprobe.exe not found in script directory!
    echo Expected: "%SCRIPT_DIR%ffprobe.exe"
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%vlc-3.0.23-win64.exe" (
    echo [ERROR] vlc-3.0.23-win64.exe not found in script directory!
    echo Expected: "%SCRIPT_DIR%vlc-3.0.23-win64.exe"
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%icon.ico" (
    echo [ERROR] icon.ico not found in script directory!
    echo Expected: "%SCRIPT_DIR%icon.ico"
    pause
    exit /b 1
)

if not exist "%SCRIPT_DIR%downloader-installer.iss" (
    echo [ERROR] downloader-installer.iss not found in script directory!
    echo Expected: "%SCRIPT_DIR%downloader-installer.iss"
    pause
    exit /b 1
)

if not exist "%ISCC_PATH%" (
    echo [ERROR] Inno Setup not found at: "%ISCC_PATH%"
    echo Please edit this file and set ISCC_PATH to the correct location
    pause
    exit /b 1
)

echo [1/3] All required files found.
echo.
echo [2/3] Compiling installer...
echo Running: "%ISCC_PATH%"
echo.

pushd "%SCRIPT_DIR%"
powershell.exe -NoProfile -Command "& '%ISCC_PATH%' '%CD%\downloader-installer.iss'"
set "ISCC_ERROR=!errorlevel!"
popd

echo.
echo ISCC exit code: !ISCC_ERROR!
echo.

if !ISCC_ERROR! neq 0 (
    echo [ERROR] ISCC compilation failed with exit code !ISCC_ERROR!.
    echo Check the output above for details.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [3/3] Done!
echo Installer created in "%SCRIPT_DIR%installer\VideoDownloader-Setup.exe"
echo ========================================
echo.
pause
