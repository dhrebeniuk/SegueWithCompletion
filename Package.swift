// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "SegueWithCompletion",
                      defaultLocalization: "en",
                      platforms: [.iOS(.v8)],
                      products: [.library(name: "SegueWithCompletion",
                                          targets: ["SegueWithCompletion"])],
                      targets: [
                            .target(name: "SegueWithCompletion",
                            path: ".", exclude: ["SegueWithCompletionExample"])
                      ],
                      swiftLanguageVersions: [.v5])
                      
