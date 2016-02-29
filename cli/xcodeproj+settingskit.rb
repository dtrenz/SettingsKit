require "pathname"
require "xcodeproj"

class Xcodeproj::Project

  def contains_file(filename)
    files.each do |file|
      if file.name == filename
        return true
      end
    end

    return false
  end

  def add_file_to_main_target(filepath)
    file_ref = new_file(filepath, "SOURCE_ROOT")

    main_target = targets.first
    main_target.add_file_references([file_ref])

    save
  end

end
