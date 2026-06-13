# wolume

Wolume is the standby runner for the older Cloudflare Worker + D1 based
notification system. Woracle is the primary system now; Wolume is kept so it can
be reactivated if Woracle has a production incident.

## Standby mode

The runner is disabled by default.

- GitHub Actions skip the Playwright run unless repository variable
  `WOLUME_RUNNER_ENABLED` is set to `1`.
- `scripts/run-cycle.js` also exits before reading secrets or calling the Worker
  unless `WOLUME_RUNNER_ENABLED=1`.
- The Worker code lives in `C:\Development\woppo-tools\wolume-manual` and should
  keep `WOLUME_STANDBY_MODE=1` while Woracle is primary.

## Reactivating Wolume

Use this only as an intentional fallback.

1. In the Cloudflare Worker, set `WOLUME_STANDBY_MODE=0`.
2. In the GitHub repository variables, set `WOLUME_RUNNER_ENABLED=1`.
3. Confirm Worker `/health` reports `standby: false`.
4. Manually run `lume-check` for one guild before enabling any scheduled or
   manual production dispatch.
