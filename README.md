# v2xios

Custom **LibXray 26.9.9** for iOS with the Android **v2x** VLESS dialect patch:

- numeric `flow` **0–255** → VLESS protocol version byte on the wire
- Vision flows (`xtls-rprx-vision` / `-udp443`) unchanged

Layout:

```
v2xios/
  libXray/          # XTLS/libXray @ v26.9.9
  Xray-core/        # patched core (from v2x)
  scripts/build-apple.sh
  Package.swift     # SPM binaryTarget (fill after release)
```

## Build (macOS only)

Windows cannot produce an iOS `.xcframework`. Use a Mac or GitHub Actions.

```bash
chmod +x scripts/build-apple.sh
./scripts/build-apple.sh
```

Output:

- `libXray/LibXray.xcframework`
- `dist/LibXray.xcframework.zip`
- `dist/Package.swift` (checksum filled; set `OWNER` in the URL)

### GitHub Actions

1. Create a GitHub repo and push this folder.
2. Run workflow **Build Apple LibXray** (Actions → workflow_dispatch), or push a tag like `26.9.9-v2x1`.
3. Download the artifact / release zip.
4. Point MiuMiuRay SPM at this repo (same product name `LibXray`).

## Use in MiuMiuRay

Replace the wanliyunyan package URL with your `v2xios` repo + release tag once `Package.swift` checksum is real.

## Patch notes

| File | Change |
|------|--------|
| `Xray-core/proxy/vless/encoding/encoding.go` | `dialectFlow` |
| `Xray-core/infra/conf/vless.go` | accept numeric flow 0–255 (inbound/outbound) |
