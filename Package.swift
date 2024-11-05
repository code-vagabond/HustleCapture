// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HustleCapture",
    platforms: [
        .macOS(.v14)  // Specify minimum macOS version (13.0 in this example)
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.10.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "HustleCapture",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ])
    ]
)
