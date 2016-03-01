require "pathname"
require "xcodeproj"

module SettingsKit
  class Integrator

    def initialize(output_filepath)
      @output_filepath = Pathname(output_filepath)
    end

    def integrate(project_path)
      project = Xcodeproj::Project.open(project_path)

      filename = @output_filepath.basename.to_s

      unless project.contains_file(filename)
        project_name = Pathname(project_path).basename
        puts "SettingsKit: Adding #{filename} to #{project_name}..."
        project.add_file_to_main_target(@output_filepath)
      end
    end

  end
end
