#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

PROJECT_NAME="Android-OS"
DISTRO="debian"

fail() { printf '\n[ERROR] %s\n' "$*" >&2; exit 1; }
info() { printf '\n[Android-OS] %s\n' "$*"; }

[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || fail "Run this script inside Termux on Android."
command -v pkg >/dev/null 2>&1 || fail "Termux package manager (pkg) was not found."

info "Updating Termux packages..."
pkg update -y
pkg upgrade -y

if ! command -v proot-distro >/dev/null 2>&1; then
  info "Installing proot-distro..."
  pkg install -y proot-distro
fi

if ! proot-distro list | grep -Eq "^[[:space:]]*debian([[:space:]]|$)"; then
  info "Installing Debian root filesystem..."
  proot-distro install "$DISTRO"
else
  info "Debian is already installed; skipping root filesystem download."
fi

info "Installing useful command-line tools inside Debian..."
proot-distro login "$DISTRO" -- bash -lc '
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends \
    ca-certificates curl wget git nano python3 python3-pip htop procps iproute2
  apt-get clean
  rm -rf /var/lib/apt/lists/*
'

info "Debian is ready."
printf '\nNext: enter Debian with: proot-distro login debian\n'
printf 'Optional desktop setup: bash setup-desktop.sh\n'
