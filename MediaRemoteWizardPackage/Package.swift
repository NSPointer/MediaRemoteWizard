// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MediaRemoteWizardPackage",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "MediaRemoteWizardShared",
            targets: ["MediaRemoteWizardShared"]
        ),
        .library(
            name: "MediaRemoteDaemonInjectionClient",
            targets: ["MediaRemoteDaemonInjectionClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Mx-Iris/swift-helper-service", branch: "main"),
    ],
    targets: [
        .target(
            name: "MediaRemoteWizardShared"
        ),
        .target(
            name: "MediaRemoteDaemonInjectionClient",
            dependencies: [
                "MediaRemoteWizardShared",
                .product(name: "HelperClient", package: "swift-helper-service"),
            ]
        ),
    ]
)
