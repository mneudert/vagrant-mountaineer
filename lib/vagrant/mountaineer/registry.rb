module VagrantPlugins
  module Mountaineer
    # Vagrant project registry
    class Registry
      I18N_KEY = 'vagrant_mountaineer.registry'.freeze

      attr_accessor :projects

      def initialize(env)
        @projects = {}
        @env      = env
      end

      def read_projectfile(projectfile)
        instance_eval(projectfile.path.read)
      end

      private

      def options_warning(name)
        @env.ui.warn I18n.t("#{I18N_KEY}.err_configuration", name: name)
        @env.ui.warn I18n.t("#{I18N_KEY}.def_ignored")
        @env.ui.warn ''
      end

      def project(name, options = nil)
        options = {} unless options.is_a?(Hash)

        return options_warning(name) unless valid_options?(options)

        options[:name] = name

        @projects[name] = options
      end

      def valid_options?(options)
        return false unless options[:guestpath].is_a?(String)
        return false unless options[:hostpath].is_a?(String)

        return false if options[:guestpath].empty?
        return false if options[:hostpath].empty?

        true
      end
    end
  end
end
