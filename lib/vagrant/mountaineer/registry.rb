module VagrantPlugins
  module Mountaineer
    # Vagrant project registry
    class Registry
      attr_accessor :projects

      def initialize(env)
        @projects = {}
        @env      = env
      end

      def read_projectfile(projectfile)
        instance_eval(projectfile.path.read)
      end

      private

      def project(name, options = nil)
        @projects[name] = options
      end
    end
  end
end
