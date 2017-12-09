#
#  Be sure to run `pod spec lint SegueWithCompletion.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SegueWithCompletion"
  s.version      = "0.1.6"
  s.summary      = "Extension for UIViewController for ability perform segue with completion handler for avoid override prepareForSegue method."
  s.description  = "Extension for UIViewController for ability perform segue with completion handler for	avoid override prepareForSegue method."

  s.homepage     = "https://github.com/dhrebeniuk/SegueWithCompletion"

  s.license      = "LICENSE"
  s.author             = { "Dmytro Hrebeniuk" => "dmytrohrebeniuk@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dhrebeniuk/SegueWithCompletion.git", :tag => "#{s.version}" }
  s.source_files  = "UIViewControllerSegueExtension.swift"

  s.requires_arc = true

end
