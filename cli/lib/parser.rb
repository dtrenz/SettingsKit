require "xcodeproj"

module SettingsKit
  class Parser

    def self.parse(plist_path)
      puts "SettingsKit: Parsing Settings.bundle/Root.plist..."
      plist = Xcodeproj::PlistHelper.read(plist_path)
      keys = plist["PreferenceSpecifiers"].map { |i| i["Key"] }.compact.sort
      Renderer.new(keys)
    end

  end
end
