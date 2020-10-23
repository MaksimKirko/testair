// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Screens",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CitySearchScreen",
            targets: ["CitySearchScreen"]),
        .library(
            name: "CurrentConditionScreen",
            targets: ["CurrentConditionScreen"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "Services")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CitySearchScreen",
            dependencies: [
                .product(name: "SettingsService", package: "Services"),
                .product(name: "WeatherService", package: "Services")
            ]),
        .testTarget(
            name: "CitySearchScreenTests",
            dependencies: ["CitySearchScreen"]),
        .target(
            name: "CurrentConditionScreen",
            dependencies: [
                .product(name: "SettingsService", package: "Services"),
                .product(name: "WeatherService", package: "Services")
            ]),
        .testTarget(
            name: "CurrentConditionScreenTests",
            dependencies: ["CurrentConditionScreen"]),
    ]
)
