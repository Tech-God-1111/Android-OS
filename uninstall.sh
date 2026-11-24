#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

fail() { printf '\n[ERROR] %s\n' "$*" >&2; exit 1; }
[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || fail "Run this script inside Termux on Android."
command -v proot-distro >/dev/null 2>&1 || fail "proot-distro is not installed; there is no Debian environment to remove."

cat <<'NOTICE'
Android-OS Debian removal

This removes the Debian container, including files, installed packages,
desktop settings, and anything saved inside Debian's home/root filesystem.

It does NOT uninstall Android, remove Termux, change Android partitions,
root the phone, or delete files stored outside the Debian container.

Back up anything you want to keep from Debian before continuing.
NOTICE

printf '\nType REMOVE-DEBIAN to confirm: '
IFS= read -r answer
[[ "$answer" == "REMOVE-DEBIAN" ]] || { echo "Cancelled. Nothing was removed."; exit 0; }

echo "[Android-OS] Stopping any running Debian VNC desktop..."
proot-distro login debian -- bash -lc 'vncserver -kill :1 >/dev/null 2>&1 || true' 2>/dev/null || true

echo "[Android-OS] Removing the Debian container..."
proot-distro remove debian

echo
echo "[Android-OS] Debian has been removed."
echo "Termux and Android are still installed and unchanged."
echo "To reinstall later, run: bash install.sh"
