module VagrantPlugins
  module Mountaineer
    # Defines the mountaineer command
    class Command < Vagrant.plugin(2, :command)
      def self.synopsis
        'mountaineer utility commands'
      end

      def execute
        command = select_command(@argv)

        return display_info if 'info' == command

        display_help
      end

      private

      def display_help
        @env.ui.info('Available commands:')
        @env.ui.info('  - help')
        @env.ui.info('  - info')
      end

      def display_info
        @env.ui.info('info...')
      end

      def select_command(argv)
        case argv[0]
        when 'help' then 'help'
        when 'info' then 'info'
        else 'help'
        end
      end
    end
  end
end
