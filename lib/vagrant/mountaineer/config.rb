module VagrantPlugins
  module Mountaineer
    # Defines the vagrant configuration
    class Config < Vagrant.plugin(2, :config)
      UTIL = VagrantPlugins::Mountaineer::Util

      attr_accessor :projectfiles

      def initialize
        @projectfiles = UNSET_VALUE
      end

      def finalize!
        @projectfiles = [] if @projectfiles == UNSET_VALUE
      end

      def validate(machine)
        errors = []

        @projectfiles.each do |file|
          errors << validate_projectfile(file, machine.env)
        end

        errors.compact!

        { 'Mountaineer configuration' => errors }
      end

      private

      def validate_projectfile(file, env)
        file_path = UTIL.env_abspath(file, env)

        return nil if file_path.exist?

        "Project file not found: #{file_path}"
      end
    end
  end
end
