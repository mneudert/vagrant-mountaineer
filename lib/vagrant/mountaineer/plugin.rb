module VagrantPlugins
  module Mountaineer
    # Vagrant plugin definition
    class Plugin < Vagrant.plugin(2)
      name 'vagrant-mountaineer'
      description VagrantPlugins::Mountaineer::SYNOPSIS

      config :mountaineer do
        Config
      end
    end
  end
end
