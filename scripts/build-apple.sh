#!/usr/bin/env bash
# Build LibXray.xcframework with the patched local Xray-core (VLESS dialect 0-255).
# Requires: macOS, Xcode CLT, Go 1.26+, Python 3, gomobile (installed by the script).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LIBXRAY="$ROOT/libXray"
XRAY="$ROOT/Xray-core"
OUT_DIR="$ROOT/dist"
VERSION="${V2XIOS_VERSION:-26.9.9-v2x4}"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "error: Apple xcframework build requires macOS + Xcode." >&2
  exit 1
fi

if [[ ! -d "$XRAY" ]]; then
  echo "error: missing local Xray-core at $XRAY" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 is required" >&2
  exit 1
fi

if ! command -v go >/dev/null 2>&1; then
  echo "error: go is required" >&2
  exit 1
fi

echo "==> building LibXray (gomobile) with local Xray-core"
cd "$LIBXRAY"
python3 build/main.py apple gomobile local

FRAMEWORK="$LIBXRAY/LibXray.xcframework"
if [[ ! -d "$FRAMEWORK" ]]; then
  echo "error: expected $FRAMEWORK after build" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
ZIP="$OUT_DIR/LibXray.xcframework.zip"
rm -f "$ZIP"
(
  cd "$LIBXRAY"
  ditto -c -k --sequesterRsrc --keepParent "LibXray.xcframework" "$ZIP"
)

CHECKSUM="$(swift package compute-checksum "$ZIP" 2>/dev/null || shasum -a 256 "$ZIP" | awk '{print $1}')"
echo "$VERSION" > "$OUT_DIR/VERSION"
echo "$CHECKSUM" > "$OUT_DIR/LibXray.xcframework.zip.sha256"

REPO_SLUG="${V2XIOS_REPO:-OWNER/v2xios}"
python3 "$ROOT/scripts/write-package-swift.py" \
  --repo "$REPO_SLUG" \
  --tag "$VERSION" \
  --checksum "$CHECKSUM" \
  --out "$OUT_DIR/Package.swift"
cp "$OUT_DIR/Package.swift" "$ROOT/Package.swift"

echo
echo "OK: $ZIP"
echo "checksum: $CHECKSUM"
echo "version:  $VERSION"
echo "Set V2XIOS_REPO=owner/name before build to bake the correct download URL."
