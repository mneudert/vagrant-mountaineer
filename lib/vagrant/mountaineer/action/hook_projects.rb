module VagrantPlugins
  module Mountaineer
    module Action
      # Vagrant project hook
      class HookProjects
        def initialize(app, env)
          @app     = app
          @machine = env[:machine]

          @config = @machine.env.vagrantfile.config
        end

        def call(env)
          files_global  = @config.mountaineer.project_files
          files_machine = @machine.config.mountaineer.project_files
          files         = (files_global + files_machine).uniq

          puts "project_files: #{files}"

          @app.call(env)
        end
      end
    end
  end
end
