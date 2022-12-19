// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PopperUp",
    platforms: [
        .iOS(.v13), .macOS(.v11),
    ],
    products: [
        .library(
            name: "PopperUp",
            targets: ["PopperUp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kamaalio/SalmonUI.git", "5.1.0"..<"6.0.0"),
    ],
    targets: [
        .target(
            name: "PopperUp",
            dependencies: [
                "SalmonUI",
            ],
            resources: [
                .process("Resources"),
            ]),
        .testTarget(
            name: "PopperUpTests",
            dependencies: ["PopperUp"]),
    ]
)
