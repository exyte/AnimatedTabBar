// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AnimatedTabBar",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "AnimatedTabBar",
            targets: ["AnimatedTabBar"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AnimatedTabBar",
            dependencies: [],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
