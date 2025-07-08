// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(
    name: "swift-ip",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .visionOS(.v2), .watchOS(.v11)],
    products: [
        .library(name: "IP", targets: ["IP"]),
        .library(name: "IP_NIOCore", targets: ["IP_NIOCore"])
    ],
    dependencies: [

        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.75.0"),
    ],
    targets: [

        .target(name: "IP"),

        .target(name: "IP_NIOCore",
            dependencies: [
                .target(name: "IP"),
                .product(name: "NIOCore", package: "swift-nio"),
            ]),

        .testTarget(name: "IPTests", dependencies: ["IP"]),
    ])

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        $0 = settings
    } (&target.swiftSettings)
}
