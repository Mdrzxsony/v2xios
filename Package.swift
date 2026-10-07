// swift-tools-version:5.7
import PackageDescription

// After GitHub Actions builds a release, replace OWNER/REPO, VERSION, and checksum
// with the values printed in dist/Package.swift (or copied from the release asset).
//
// Local path (after `./scripts/build-apple.sh` on a Mac):
//   .binaryTarget(name: "LibXray", path: "libXray/LibXray.xcframework")

let package = Package(
    name: "LibXray",
    products: [
        .library(name: "LibXray", targets: ["LibXray"])
    ],
    targets: [
        .binaryTarget(
            name: "LibXray",
            url: "https://github.com/OWNER/v2xios/releases/download/26.9.9-v2x1/LibXray.xcframework.zip",
            checksum: "REPLACE_AFTER_BUILD"
        )
    ]
)
