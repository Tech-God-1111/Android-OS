#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || { echo "Run inside Termux." >&2; exit 1; }
proot-distro login debian -- bash -lc 'vncserver -kill :1 || true'
echo "[Android-OS] Desktop session stopped."
