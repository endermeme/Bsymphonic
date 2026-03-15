#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

JRE_URL="${JRE_URL:-https://api.adoptium.net/v3/binary/latest/8/ga/windows/x86/jre/hotspot/normal/eclipse}"
WORK_DIR="$ROOT_DIR/build/windows-portable"
DIST_DIR="$WORK_DIR/BinhTagilla-JSymphonic"
RUNTIME_DIR="$DIST_DIR/jre"
CACHE_DIR="$WORK_DIR/cache"
JRE_ARCHIVE="$CACHE_DIR/windows-jre8.zip"
JRE_EXTRACT_DIR="$CACHE_DIR/jre-unpacked"

command -v mvn >/dev/null 2>&1 || { echo "[ERROR] mvn khong co trong PATH."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "[ERROR] curl khong co trong PATH."; exit 1; }
command -v bsdtar >/dev/null 2>&1 || { echo "[ERROR] bsdtar khong co trong PATH."; exit 1; }

echo "[1/5] Build fat jar va wrapper .exe..."
export MAVEN_OPTS="--add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang.reflect=ALL-UNNAMED --add-opens java.base/java.text=ALL-UNNAMED --add-opens java.desktop/java.awt.font=ALL-UNNAMED"
mvn -B -DskipTests verify

rm -rf "$WORK_DIR"
mkdir -p "$DIST_DIR" "$CACHE_DIR" "$JRE_EXTRACT_DIR"

echo "[2/5] Copy file app..."
cp target/windows-portable/BinhTagilla-JSymphonic.exe "$DIST_DIR/"
cp target/windows-portable/jsymphonic.jar "$DIST_DIR/"

echo "[3/5] Lay JRE Windows 8 tu Adoptium..."
curl -L "$JRE_URL" -o "$JRE_ARCHIVE"

echo "[4/5] Giai nen va bundle JRE..."
rm -rf "$JRE_EXTRACT_DIR"
mkdir -p "$JRE_EXTRACT_DIR"
bsdtar -xf "$JRE_ARCHIVE" -C "$JRE_EXTRACT_DIR"
JRE_ROOT="$(find "$JRE_EXTRACT_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "${JRE_ROOT:-}" || ! -f "$JRE_ROOT/bin/javaw.exe" ]]; then
  echo "[ERROR] JRE da tai ve nhung cau truc khong dung."
  exit 1
fi
rm -rf "$RUNTIME_DIR"
mkdir -p "$RUNTIME_DIR"
cp -R "$JRE_ROOT"/. "$RUNTIME_DIR"/

echo "[5/5] Copy ffmpeg tuy chon..."
if [[ -n "${FFMPEG_EXE:-}" && -f "${FFMPEG_EXE:-}" ]]; then
  cp "$FFMPEG_EXE" "$DIST_DIR/ffmpeg.exe"
  echo "[INFO] Da copy ffmpeg.exe vao goi portable."
fi

echo
echo "Hoan tat. App portable nam tai:"
echo "  $DIST_DIR"
echo
echo "May dich khong can cai Java vi da co san jre Windows."
echo "Neu can transcode dinh dang ngoai MP3/ATRAC, hay kem ffmpeg.exe."
