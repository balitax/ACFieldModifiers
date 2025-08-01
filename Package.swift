// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACFieldModifiers",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ACFieldModifiers",
            targets: ["ACFieldModifiers"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ACFieldModifiers", dependencies: []),
        .testTarget(
            name: "ACFieldModifiersTests",
            dependencies: ["ACFieldModifiers"]
        ),
    ]
)
