// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Pink_CovenAPI",
    platforms: [.macOS(.v10_15)],
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.8.0")),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
      .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "9.0.0"),
      .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
      .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
      .package(url: "https://github.com/IBM-Swift/Swift-Kuery-ORM.git", from: "0.6.0"),
      .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", from: "2.1.1")
    ],
    targets: [
      .target(name: "Pink_CovenAPI", dependencies: [ .target(name: "Application") ]),
      .target(name: "Application", dependencies: [ "Kitura", "HeliumLogger", "CloudEnvironment","SwiftMetrics", "Health", "SwiftKueryPostgreSQL", "SwiftKueryORM"

      ]),

      .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura", "HeliumLogger" ])
    ]
)
