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
            url: "https://github.com/OWNER/v2xios/releases/download/26.9.9-v2x2/LibXray.xcframework.zip",
            checksum: "9ff4bbbd49a78594357df057f935f276096eb797cbb4c39324014ca3582060e1"
        )
    ]
)
