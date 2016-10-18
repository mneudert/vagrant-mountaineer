module VagrantPlugins
  module Mountaineer
    # Defines the vagrant configuration
    class Config < Vagrant.plugin(2, :config)
      UTIL = VagrantPlugins::Mountaineer::Util

      attr_accessor :project_files

      def initialize
        @project_files = UNSET_VALUE
      end

      def finalize!
        @project_files = [] if @project_files == UNSET_VALUE
      end

      def validate(machine)
        errors = []

        @project_files.each do |file|
          errors << validate_project_file(file, machine.env)
        end

        errors.compact!

        { 'Mountaineer configuration' => errors }
      end

      private

      def validate_project_file(file, env)
        file_path = UTIL.env_abspath(file, env)

        return nil if file_path.exist?

        "Project file not found: #{file_path}"
      end
    end
  end
end
