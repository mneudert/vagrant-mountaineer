module VagrantPlugins
  module Mountaineer
    # Vagrant plugin definition
    module Action
      include Vagrant::Action::Builtin

      def self.hook_projects
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use HookProjects
        end
      end
    end
  end
end
