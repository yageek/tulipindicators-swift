// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "tulipindicators",
    products: [
        .library(
            name: "tulipindicators",
            targets: ["tulipindicators"]),
    ],
    targets: [
        .target(
            name: "tulipindicators",
            dependencies: ["libindicators"]),
        .target(
            name: "libindicators",
            dependencies: []),
        .testTarget(
            name: "tulipindicatorsTests",
            dependencies: ["tulipindicators"]),
    ]
)
