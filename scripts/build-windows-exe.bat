@echo off
setlocal EnableExtensions EnableDelayedExpansion

where mvn >NUL 2>&1
if errorlevel 1 (
  echo [ERROR] Maven ^(mvn^) khong co trong PATH.
  echo         Can Maven de build source.
  exit /b 1
)

if "%JAVA8_RUNTIME_HOME%"=="" (
  echo [ERROR] Chua set JAVA8_RUNTIME_HOME.
  echo         Hay tro den mot thu muc JRE/JDK 8 de dong goi app portable khong can cai Java tren may dich.
  echo         Vi du: set JAVA8_RUNTIME_HOME=C:\Java\jre8
  exit /b 1
)

if not exist "%JAVA8_RUNTIME_HOME%\bin\javaw.exe" (
  echo [ERROR] JAVA8_RUNTIME_HOME khong hop le: %JAVA8_RUNTIME_HOME%
  echo         Khong tim thay bin\javaw.exe
  exit /b 1
)

echo [1/4] Build fat jar va wrapper .exe...
set "JAVA_MAJOR="
for /f "tokens=3 delims=.\" %%A in ('java -version 2^>^&1 ^| findstr /i "version"') do (
  if "%%A"=="1" (
    for /f "tokens=4 delims=.\"" %%B in ('java -version 2^>^&1 ^| findstr /i "version"') do (
      set "JAVA_MAJOR=%%B"
    )
  ) else (
    set "JAVA_MAJOR=%%A"
  )
)

if not defined JAVA_MAJOR (
  echo [ERROR] Khong xac dinh duoc phien ban Java dang chay cung Maven.
  exit /b 1
)

set "MAVEN_OPTS="
if !JAVA_MAJOR! GEQ 9 (
  set "MAVEN_OPTS=--add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang.reflect=ALL-UNNAMED --add-opens java.base/java.text=ALL-UNNAMED --add-opens java.desktop/java.awt.font=ALL-UNNAMED"
)
call mvn -DskipTests verify
if errorlevel 1 (
  echo [ERROR] Maven build that bai.
  exit /b 1
)

set "WORK_DIR=build\windows-portable"
set "DIST_DIR=%WORK_DIR%\BinhTagilla-JSymphonic"
set "RUNTIME_DIR=%DIST_DIR%\jre"

if exist "%WORK_DIR%" rmdir /s /q "%WORK_DIR%"
mkdir "%DIST_DIR%"
mkdir "%RUNTIME_DIR%"

if not exist "target\windows-portable\BinhTagilla-JSymphonic.exe" (
  echo [ERROR] Khong tim thay file exe wrapper do Launch4j tao ra.
  exit /b 1
)

if not exist "target\windows-portable\jsymphonic.jar" (
  echo [ERROR] Khong tim thay jsymphonic.jar trong target\windows-portable\.
  exit /b 1
)

echo [2/4] Copy file app...
copy /Y "target\windows-portable\BinhTagilla-JSymphonic.exe" "%DIST_DIR%\BinhTagilla-JSymphonic.exe" >NUL
copy /Y "target\windows-portable\jsymphonic.jar" "%DIST_DIR%\jsymphonic.jar" >NUL

echo [3/4] Bundle Java 8 runtime...
xcopy "%JAVA8_RUNTIME_HOME%\*" "%RUNTIME_DIR%\" /E /I /Y >NUL
if errorlevel 1 (
  echo [ERROR] Copy Java runtime that bai.
  exit /b 1
)

echo [4/4] Kiem tra ffmpeg tuy chon...
if defined FFMPEG_EXE (
  if exist "%FFMPEG_EXE%" (
    copy /Y "%FFMPEG_EXE%" "%DIST_DIR%\ffmpeg.exe" >NUL
    echo [INFO] Da copy ffmpeg.exe vao goi portable.
  )
)

echo.
echo Hoan tat. App portable nam tai:
echo   %DIST_DIR%
echo.
echo May dich KHONG can cai Java neu da bundle jre.
echo Neu muon transcode dinh dang ngoai MP3/ATRAC, van can ffmpeg.exe.
echo Windows XP chi la best-effort, khong the cam ket on dinh tren moi may XP.
endlocal
