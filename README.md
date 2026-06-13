# wolume

Wolume is the standby runner for the older Cloudflare Worker + D1 based
notification system. Woracle is the primary system now; Wolume is kept so it can
be reactivated if Woracle has a production incident.

## Standby mode

Wolume is not scheduled while Woracle is primary.

- Remove the Cloudflare Cron Trigger while Wolume is only a standby. This stops
  the scheduled Worker invocation itself.
- The Worker code lives in `C:\Development\woppo-tools\wolume-manual` and should
  keep `WOLUME_STANDBY_MODE=1` while Woracle is primary. This prevents manual
  dispatch, runner access, and D1 work inside the Worker.

## Reactivating Wolume

Use this only as an intentional fallback.

1. In the Cloudflare Worker, set `WOLUME_STANDBY_MODE=0`.
2. Confirm Worker `/health` reports `standby: false`.
3. Manually run `lume-check` for one guild before enabling any scheduled or
   manual production dispatch.
4. Add the Cloudflare Cron Trigger only after the manual check succeeds.
