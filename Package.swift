// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MSwiftUINavigator",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MSwiftUINavigator",
            targets: ["MSwiftUINavigator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gordontucker/FittedSheets.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MSwiftUINavigator",
            dependencies: ["FittedSheets"]),
        .testTarget(
            name: "MSwiftUINavigatorTests",
            dependencies: ["MSwiftUINavigator"]),
    ],
    swiftLanguageVersions: [.v5]
)
