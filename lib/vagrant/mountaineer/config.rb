module VagrantPlugins
  module DevCommands
    # Defines the vagrant configuration
    class Command < Vagrant.plugin(2, :config)
      attr_accessor :project_files

      def initialize
        @project_files = UNSET_VALUE
      end

      def finalize!
        @project_files = [] if @project_files == UNSET_VALUE
      end
    end
  end
end
