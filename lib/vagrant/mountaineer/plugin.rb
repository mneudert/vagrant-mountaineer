module VagrantPlugins
  module Mountaineer
    # Vagrant plugin definition
    class Plugin < Vagrant.plugin(2)
      name 'vagrant-mountaineer'
      description VagrantPlugins::Mountaineer::SYNOPSIS

      config :mountaineer do
        Config
      end

      action_hook(:mountaineer, :machine_action_up) do |hook|
        hook.prepend(VagrantPlugins::Mountaineer::Action.hook_projects)
      end
    end
  end
end
