@echo off
setlocal EnableExtensions EnableDelayedExpansion

call "%~dp0build-windows-exe.bat"
if errorlevel 1 exit /b 1

set "ISCC_CMD=%ISCC_PATH%"
if "%ISCC_CMD%"=="" set "ISCC_CMD=iscc"

echo [5/5] Build bo cai installer...
%ISCC_CMD% "%~dp0build-windows-installer.iss"
if errorlevel 1 (
  echo [ERROR] Tao installer that bai.
  exit /b 1
)

echo.
echo Hoan tat. Installer nam tai:
echo   build\windows-installer\BinhTagilla-JSymphonic-Setup.exe
endlocal
