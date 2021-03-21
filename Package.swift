// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "SegueWithCompletion",
                      defaultLocalization: "en",
                      platforms: [.iOS(.v8)],
                      products: [.library(name: "SegueWithCompletion",
                                          targets: ["SegueWithCompletion"])],
                      targets: [
                            .target(name: "SegueWithCompletionExample",
                            path: ".",
                            exclude: ["AppDelegate.swift", "ModalScreenViewController.swift", "MainScreenViewController.swift", "DetailsScreenViewController.swift", "ModelObject.swift", "Main.storyboard", "LaunchScreen.storyboard", "Info.plist"])
                      ],
                      swiftLanguageVersions: [.v5])
                      
