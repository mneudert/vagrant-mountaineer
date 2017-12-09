module VagrantPlugins
  module Mountaineer
    # Action hook definition
    module Action
      include Vagrant::Action::Builtin

      def self.hook_projects
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use HookProjects
        end
      end
    end
  end
end
