module VagrantPlugins
  module Mountaineer
    # Utility module
    class Util
      def self.env_abspath(path, env)
        file_path = Pathname.new(path)

        unless file_path.absolute?
          file_path = Pathname.new(env.root_path) + file_path
        end

        file_path
      end
    end
  end
end
