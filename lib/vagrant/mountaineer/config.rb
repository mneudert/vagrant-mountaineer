# frozen_string_literal: true

module VagrantPlugins
  module Mountaineer
    # Vagrant configuration definition
    class Config < Vagrant.plugin(2, :config)
      I18N_KEY = 'vagrant_mountaineer.config'
      UTIL = VagrantPlugins::Mountaineer::Util

      attr_accessor :projectfiles

      def initialize
        super

        @projectfiles = UNSET_VALUE
      end

      def finalize!
        @projectfiles = [] if @projectfiles == UNSET_VALUE
      end

      def validate(machine)
        errors = @projectfiles.map do |file|
          validate_projectfile(file, machine.env)
        end

        errors.compact!

        { 'Mountaineer configuration' => errors }
      end

      private

      def validate_projectfile(file, env)
        file_path = UTIL.env_abspath(file, env)

        return nil if file_path.exist?

        I18n.t("#{I18N_KEY}.projectfile_not_found", file_path: file_path)
      end
    end
  end
end
