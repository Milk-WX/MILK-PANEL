#!/usr/bin/env bash
# Public, stable bootstrap for the Milk Master personal release.
set -euo pipefail

REPOSITORY="${MILK_GITHUB_REPOSITORY:-Milk-WX/MILK-PANEL}"
REF="${MILK_GITHUB_REF:-main}"
ARCHIVE="${MILK_RELEASE_ARCHIVE:-milk-personal-linux-amd64.tar.gz}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf -- "$TMP_DIR"' EXIT

die() { echo "error: $*" >&2; exit 1; }
[[ "$(id -u)" -eq 0 ]] || die "run with sudo or as root"

download() {
  local url="$1" output="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fL --retry 2 --connect-timeout 10 "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    die "curl or wget is required"
  fi
}

case "$(uname -m)" in
  x86_64|amd64) ;;
  *) die "the public personal archive currently supports Linux amd64; use the matching release package for $(uname -m)" ;;
esac

BASE_URL="https://raw.githubusercontent.com/${REPOSITORY}/${REF}"
ARCHIVE_PATH="$TMP_DIR/$ARCHIVE"
download "$BASE_URL/$ARCHIVE" "$ARCHIVE_PATH"
download "$BASE_URL/SHA256SUMS" "$TMP_DIR/SHA256SUMS"
if command -v sha256sum >/dev/null 2>&1; then
  (cd "$TMP_DIR" && grep "  $ARCHIVE$" SHA256SUMS | sha256sum -c -)
fi

tar -xzf "$ARCHIVE_PATH" -C "$TMP_DIR"
PACKAGE_DIR="$TMP_DIR/milk-personal-linux-amd64"
[[ -f "$PACKAGE_DIR/install-master.sh" ]] || die "release archive is missing install-master.sh"
cd "$PACKAGE_DIR"
chmod +x install-master.sh
exec ./install-master.sh ./milk-master
