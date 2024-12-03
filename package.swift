// swift-tools-version: 6.0
import PackageDescription

let packageDependencies: [Package.Dependency] = [
  .package(
    url: "https://github.com/apple/swift-collections.git",
    exact: "1.1.4"
  ),
  .package(
    url: "https://github.com/apple/swift-argument-parser.git",
    exact: "1.5.0"
  ),
  .package(
    url: "https://github.com/apple/swift-algorithms",
    from: "1.2.0"
  )
]

let targetDependencies: [Target.Dependency] = [
  .product(name: "Collections", package: "swift-collections"),
  .product(name: "ArgumentParser", package: "swift-argument-parser"),
  .product(name: "Algorithms", package: "swift-algorithms")
]

let package = Package(
  name: "AdventOfCode24",
  platforms: [.macOS(.v15)],
  dependencies: packageDependencies,
  targets: [
    .executableTarget(
      name: "AdventOfCode24",
      dependencies: targetDependencies, 
      resources: [.copy("Input")]
    )
  ]
)
