// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "QuerySerialization",
    products: [
        .library(name: "QuerySerialization", targets: ["QuerySerialization"])
    ],
    targets: [
        .target(name: "QuerySerialization", path: "Sources"),
        .testTarget(name: "QuerySerializationTests")
    ]
)
