module VagrantPlugins
  module Mountaineer
    # Defines the vagrant configuration
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :project_files

      def initialize
        @project_files = UNSET_VALUE
      end

      def finalize!
        @project_files = [] if @project_files == UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors

        @project_files.each do |file|
          errors << validate_project_file(file, machine.env.root_path)
        end

        errors.compact!

        { 'Mountaineer configuration' => errors }
      end

      private

      def validate_project_file(file, root)
        file_path = Pathname.new(file)
        file_path = Pathname.new(root) + file_path unless file_path.absolute?

        return nil if file_path.exist?

        "Project file not found: #{file_path}"
      end
    end
  end
end
