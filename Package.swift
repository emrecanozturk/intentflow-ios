// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "IntentFlow",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "IntentFlow",
            targets: ["IntentFlow"]
        ),
        .library(
            name: "IntentFlowAI",
            targets: ["IntentFlowAI"]
        ),
        .executable(
            name: "intentflow-generate",
            targets: ["IntentFlowGenerate"]
        )
    ],
    targets: [
        .target(
            name: "IntentFlow"
        ),
        .target(
            name: "IntentFlowAI",
            dependencies: ["IntentFlow"]
        ),
        .executableTarget(
            name: "IntentFlowGenerate",
            dependencies: ["IntentFlowAI"]
        ),
        .testTarget(
            name: "IntentFlowTests",
            dependencies: ["IntentFlow"]
        ),
        .testTarget(
            name: "IntentFlowAITests",
            dependencies: ["IntentFlowAI"]
        ),
        .testTarget(
            name: "IntentFlowGenerateTests",
            dependencies: ["IntentFlowGenerate"]
        )
    ]
)
