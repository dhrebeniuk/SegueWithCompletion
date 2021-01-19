import PackageDescription

let package = Package(name: "SegueWithCompletion",
                      platforms: [.iOS(.v8)],
                      products: [.library(name: "SegueWithCompletion",
                                          targets: ["SegueWithCompletion"])],
                      targets: [.target(name: "SegueWithCompletion",
                                        path: ".")],
                      swiftLanguageVersions: [.v5])
                      
