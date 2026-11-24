#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || { echo "Run inside Termux." >&2; exit 1; }
command -v proot-distro >/dev/null 2>&1 || { echo "Run bash install.sh first." >&2; exit 1; }

echo "[Android-OS] Installing XFCE and TigerVNC in Debian..."
proot-distro login debian -- bash -lc '
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends xfce4 dbus-x11 tigervnc-standalone-server tigervnc-common
  apt-get clean
  rm -rf /var/lib/apt/lists/*
'
echo
echo "Desktop packages installed."
echo "Next: bash start-desktop.sh"
echo "Connect your on-device VNC viewer to 127.0.0.1:5901."
