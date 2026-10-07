# Patches vs stock Xray-core (libXray v26.9.9 pin)

Source: Android `v2x` tree (`C:\app\tools\v2x\xray-core`).

## VLESS dialect flow (0–255)

Stock Xray always writes protocol version `0`. Some peers expect the version byte to match a numeric client `flow` token.

1. **`proxy/vless/encoding/encoding.go`**
   - Adds `dialectFlow`: if `addons.Flow` parses as integer 0–255, set `request.Version` and clear flow so it is not sent as XTLS Vision.
2. **`infra/conf/vless.go`**
   - Inbound/outbound validators accept numeric flow 0–255 in addition to Vision names.

Vision (`xtls-rprx-vision`, `xtls-rprx-vision-udp443`) behavior is unchanged.
