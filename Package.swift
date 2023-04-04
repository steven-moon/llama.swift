// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "llama.swift",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Llama",
            targets: ["Llama"]),
        .library(
            name: "CLlama",
            targets: ["CLlama"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Llama",
            dependencies: ["CLlama"],
            resources: []
        ),
        .target(
            name: "CLlama",
            sources: ["ggml.c", "llama.cpp"],
            publicHeadersPath: "spm-headers",
            cSettings: [
                .unsafeFlags(["-O3"]),
                .unsafeFlags(["-w"])    // ignore all warnings
            ]),
        .testTarget(
            name: "LlamaTests",
            dependencies: ["Llama"],
            resources: [
                .copy("Resources/gpt4all-lora-quantized.bin"),
            ]),
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)
