# wolume

Wolume is the reserve runner for the older Cloudflare Worker + D1 based
notification system. Woracle is the primary system now; Wolume is kept so it can
be reactivated if Woracle has a production incident.

## Reserve scheduling

Wolume is not scheduled while Woracle is primary.

- Remove the Cloudflare Cron Trigger while Wolume is only a reserve. This stops
  the scheduled Worker invocation itself.
- The Worker code lives in `C:\Development\woppo-tools\wolume-manual` and should
  stay deployable without an extra runtime flag. Cron Trigger presence is the
  switch for scheduled production work.

## Reactivating Wolume

Use this only as an intentional reserve path.

1. Confirm Worker `/health` is reachable.
2. Manually run `lume-check` for one guild before enabling any scheduled or
   manual production dispatch.
3. Add the Cloudflare Cron Trigger only after the manual check succeeds.
