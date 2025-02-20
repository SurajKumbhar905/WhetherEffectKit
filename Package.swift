// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhetherEffectKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WhetherEffectKit",
            targets: ["WhetherEffectKit"]),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WhetherEffectKit",
            resources: [
                        .process("RainFall.sks"),
                        .process("SnowFall.sks"),
                        .process("RainFallLanding.sks"),
                        .process("SnowFallLanding.sks"),
                        .process("spark.png"),
                        .process("Ellipse1.png"),
                        ]
                        
        ),
        
        .testTarget(
            name: "WhetherEffectKitTests",
            dependencies: ["WhetherEffectKit"]
        ),
        
    ]
)
