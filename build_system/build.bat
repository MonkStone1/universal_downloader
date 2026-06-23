@echo off
setlocal

echo Checking for Python...
echo.

where python >nul 2>&1
if not errorlevel 1 (
    set "PYEXE=python"
    goto :found
)

where py >nul 2>&1
if not errorlevel 1 (
    set "PYEXE=py"
    goto :found
)

echo [ERROR] Python not found.
pause
exit /b 1

:found
echo [OK] Found: %PYEXE%
%PYEXE% --version
echo.

if not exist "downloader.py" (
    echo [ERROR] downloader.py not found next to this bat file!
    pause
    exit /b 1
)

if not exist "app" (
    echo [ERROR] "app" folder not found next to this bat file!
    echo Make sure app\config.py, app\gui.py etc. are present.
    pause
    exit /b 1
)

echo [1/3] Installing dependencies...
%PYEXE% -m pip install --upgrade yt-dlp pillow pystray tkinterdnd2 nuitka zstandard
if errorlevel 1 (
    echo [ERROR] pip install failed.
    pause
    exit /b 1
)
echo       Done.
echo.

echo [2/3] Compiling... (2-5 min)
echo       Excluding yt_dlp.extractor.lazy_extractors (huge generated file
echo       that crashes MSVC with "out of heap space" - it is not needed,
echo       yt-dlp falls back to normal extractors automatically).
echo.

%PYEXE% -m nuitka --onefile --windows-console-mode=disable --enable-plugin=tk-inter --include-package=app --include-package=yt_dlp --nofollow-import-to=yt_dlp.extractor.lazy_extractors --include-package=PIL --include-package=pystray --include-package=tkinterdnd2 --output-filename=downloader.exe --assume-yes-for-downloads --jobs=2 downloader.py

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed. See log above.
    echo If it crashed again with "out of heap space", try option 2:
    echo close other programs to free RAM, or use PyInstaller instead
    echo ^(see build_pyinstaller.bat^).
    pause
    exit /b 1
)

echo.
echo [3/3] Done! downloader.exe is ready in this folder.
echo.
echo NOTE: copy ffmpeg.exe + ffprobe.exe next to downloader.exe
echo Download: https://www.gyan.dev/ffmpeg/builds/
echo.
pause
