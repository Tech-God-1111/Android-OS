#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || { echo "Run inside Termux." >&2; exit 1; }
command -v proot-distro >/dev/null 2>&1 || { echo "Run bash install.sh first." >&2; exit 1; }

echo "[Android-OS] Starting Debian XFCE VNC server on localhost:5901..."
proot-distro login debian -- bash -lc '
  set -e
  mkdir -p "$HOME/.vnc"
  cat > "$HOME/.vnc/xstartup" << "EOF"
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec dbus-launch --exit-with-session startxfce4
EOF
  chmod 700 "$HOME/.vnc"
  chmod +x "$HOME/.vnc/xstartup"
  vncserver :1 -localhost yes -geometry 1280x720 -depth 24
'
echo
echo "If this is the first launch, TigerVNC may ask you to set a VNC password."
echo "Connect an Android VNC viewer to 127.0.0.1:5901."
