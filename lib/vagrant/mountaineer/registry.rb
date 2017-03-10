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

      def config_warning(name)
        @env.ui.warn I18n.t("#{I18N_KEY}.err_configuration", name: name)
        @env.ui.warn I18n.t("#{I18N_KEY}.def_ignored")
        @env.ui.warn ''
      end

      def project(name, config = nil)
        config           = {} unless config.is_a?(Hash)
        config[:options] = {} unless config[:options].is_a?(Hash)

        return config_warning(name) unless valid_config?(config)

        config[:name] = name

        @projects[name] = config
      end

      def valid_config?(config)
        return false unless config[:guestpath].is_a?(String)
        return false unless config[:hostpath].is_a?(String)

        return false if config[:guestpath].empty?
        return false if config[:hostpath].empty?

        true
      end
    end
  end
end
