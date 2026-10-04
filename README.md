# sms-limit-apply (deprecated — see woodmanlegion/termux-sms)

**Deprecated 2026-10-03.** Folded into [`woodmanlegion/termux-sms`](https://github.com/woodmanlegion/termux-sms)
along with `skill-sms-send`, `skill-mms-send`, and `skill-mms-receive`.
The rate-limit bypass is now applied automatically by `sms-send` before
every send and once per cycle by the shared poller (`termux-sms-poll`)
— no separate boot hook needed, since both already cover the real need.
Archived.

---

Bypass the Android SMS outgoing rate-limit by patching two global settings via root. Includes a Termux:Boot hook so the settings survive device restarts.

## Why this exists

Android enforces a default limit of ~30 SMS per 30 minutes. When exceeded, a dialog appears asking the user to confirm continued sending — which blocks any automated or agentic SMS flow. The limit is configurable via `settings put global` but resets on reboot.

## Requirements

- Root (`su` available)
- Termux:Boot app (F-Droid) for automatic re-application on boot

## Install

```bash
bash install.sh
```

Installs `sms-limit-apply` to `~/.local/bin/` and the boot hook to `~/.termux/boot/`, then applies settings immediately.

## What it does

```bash
su -c "settings put global sms_outgoing_check_max_count 99999"
su -c "settings put global sms_outgoing_check_interval_ms 99999999"
```

## Manual use

```bash
sms-limit-apply          # apply now (requires root)
```

## Boot hook

`~/.termux/boot/sms-limit-apply` runs automatically when the device starts (via Termux:Boot). Waits 5 seconds after boot before applying to allow Android to settle.

## Verify

```bash
su -c "settings get global sms_outgoing_check_max_count"    # expect 99999
su -c "settings get global sms_outgoing_check_interval_ms"  # expect 99999999
```
