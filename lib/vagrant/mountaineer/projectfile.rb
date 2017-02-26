module VagrantPlugins
  module Mountaineer
    # Mountaineer project file representation
    class Projectfile
      def initialize(env, path)
        @env  = env
        @path = Pathname.new(path)
      end

      def exist?
        nil != path
      end

      def path
        locate_projectfile
      end

      private

      def locate_projectfile
        if @path.absolute?
          return nil unless @path.exist?
          return @path
        end

        return nil unless @env.root_path

        path = @env.root_path.join(@path)

        return nil unless path.exist?

        path
      end
    end
  end
end
