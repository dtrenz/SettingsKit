require "xcodeproj"

module SettingsKit
  class Parser

    def self.parse(plist_path)
      puts "SettingsKit: Parsing #{plist_path}..."
      # plist = Xcodeproj::PlistHelper.read(plist_path)
      plist = Xcodeproj::Plist.read_from_path(plist_path)
      keys = plist["PreferenceSpecifiers"].map { |i| i["Key"] }.compact.sort
      Renderer.new(keys)
    end

  end
end
