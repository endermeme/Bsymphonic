#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ISCC_CMD="${ISCC_PATH:-}"
if [[ -z "$ISCC_CMD" ]]; then
  ISCC_CMD="wine iscc.exe"
fi

echo "[1/2] Build app portable..."
./scripts/build-windows-exe.sh

echo "[2/2] Build bo cai installer..."
cd scripts
"$ISCC_CMD" build-windows-installer.iss

echo
echo "Hoan tat. Installer nam tai:"
echo "  $ROOT_DIR/build/windows-installer/BinhTagilla-JSymphonic-Setup.exe"
