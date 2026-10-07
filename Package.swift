// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LibXray",
    products: [
        .library(name: "LibXray", targets: ["LibXray"])
    ],
    targets: [
        .binaryTarget(
            name: "LibXray",
            url: "https://github.com/Mdrzxsony/v2xios/releases/download/26.9.9-v2x1/LibXray.xcframework.zip",
            checksum: "a20d3dd86644d6cd774a35c949c64648c6dbe96f26cbcdc9ec7cadf9f1d8a27f"
        )
    ]
)
