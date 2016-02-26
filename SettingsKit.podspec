Pod::Spec.new do |s|
  s.name             = "SettingsKit"
  s.version          = "0.1.0"
  s.summary          = <<-SUMMARY
                       SUMMARY
  s.description      = <<-DESC
                       DESC
  s.homepage         = "https://github.com/dtrenz/SettingsKit"
  s.license          = 'Apache 2.0'
  s.author           = { "Dan Trenz" => "dtrenz@gmail.com" }
  s.source           = { :git => "https://github.com/dtrenz/SettingsKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dtrenz'
  s.platform         = :ios, '8.3'
  s.requires_arc     = true
  s.source_files     = 'Sources/**/*'
end
