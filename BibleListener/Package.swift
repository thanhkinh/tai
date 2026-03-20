// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BibleListener",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "BibleListener", targets: ["BibleListener"]),
    ],
    targets: [
        .target(
            name: "BibleListener",
            path: "BibleListener"
        ),
    ]
)
