source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

workspace 'SettingsKit.xcworkspace'

target 'SettingsKitTests', :exclusive => true do
  xcodeproj 'SettingsKit.xcodeproj'
  pod 'Quick', '~> 0.8.0'
  pod 'Nimble', '3.0.0'
end

target 'Example', :exclusive => true do
  xcodeproj 'Example/Example.xcodeproj'
  pod 'SettingsKit', :path => '.'
end

