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

          puts "global project files:  #{files_global}"
          puts "machine project_files: #{files_machine}"

          @app.call(env)
        end
      end
    end
  end
end
