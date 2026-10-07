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
            url: "https://github.com/Mdrzxsony/v2xios/releases/download/26.9.9-v2x3/LibXray.xcframework.zip",
            checksum: ""
        )
    ]
)
