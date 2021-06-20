# frozen_string_literal: true

module VagrantPlugins
  module Mountaineer
    # Utility module
    class Util
      def self.env_abspath(path, env)
        file_path = Pathname.new(path)
        file_path = Pathname.new(env.root_path) + file_path unless file_path.absolute?

        file_path
      end

      def self.pad_to(items)
        items = items.keys unless items.is_a?(Array)

        items.map(&:length).max
      end
    end
  end
end
