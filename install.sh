#!/data/data/com.termux/files/usr/bin/bash
# Install sms-limit-apply and its Termux boot hook.
# Idempotent — safe to re-run.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
BOOT_DIR="$HOME/.termux/boot"

mkdir -p "$LOCAL_BIN" "$BOOT_DIR"

# ── Main binary ───────────────────────────────────────────────────────────────

cp "$SCRIPT_DIR/bin/sms-limit-apply" "$LOCAL_BIN/sms-limit-apply"
chmod +x "$LOCAL_BIN/sms-limit-apply"
echo "Installed: $LOCAL_BIN/sms-limit-apply"

# ── Termux boot hook ──────────────────────────────────────────────────────────

cp "$SCRIPT_DIR/boot/sms-limit-apply" "$BOOT_DIR/sms-limit-apply"
chmod +x "$BOOT_DIR/sms-limit-apply"
echo "Boot hook: $BOOT_DIR/sms-limit-apply"

# ── Apply now ─────────────────────────────────────────────────────────────────

echo "Applying rate-limit settings now ..."
"$LOCAL_BIN/sms-limit-apply"

echo
echo "=== Done ==="
echo "Settings applied. Will re-apply automatically on next boot via Termux:Boot."
echo "Requires: Termux:Boot app installed from F-Droid."
