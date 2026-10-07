# Patches vs stock Xray-core (libXray v26.9.9 pin)

Source: Android `v2x` tree (`C:\app\tools\v2x\xray-core`).

## VLESS dialect flow (0–255)

Stock Xray always writes protocol version `0`. Some peers expect the version byte to match a numeric client `flow` token.

1. **`proxy/vless/encoding/encoding.go`**
   - Adds `dialectFlow`: if `addons.Flow` parses as integer 0–255, set `request.Version` and clear flow so it is not sent as XTLS Vision.
2. **`infra/conf/vless.go`**
   - Inbound/outbound validators accept numeric flow 0–255 in addition to Vision names.

Vision (`xtls-rprx-vision`, `xtls-rprx-vision-udp443`) behavior is unchanged.

## libXray pingBatch cap (v2x4)

3. **`libXray/xray/ping_batch.go`**
   - `maxPingBatchConfigs` 5 → 64. One `pingBatch` call probes all items in
     parallel inside a single Xray instance, and calls are serialized by
     `coreServerMu`, so the cap is the app's real ping concurrency.
