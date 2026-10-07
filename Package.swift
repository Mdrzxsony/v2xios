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
            url: "https://github.com/Mdrzxsony/v2xios/releases/download/26.9.9-v2x4/LibXray.xcframework.zip",
            checksum: "09f4e947a2f7002550ddb7bc84e72ae538b42ad114f6bc95f66a8f2db5fb329e"
        )
    ]
)
