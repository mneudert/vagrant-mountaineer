module VagrantPlugins
  module Mountaineer
    module Action
      # Project hook to load and mount projectfile contents
      class HookProjects
        PROJECTFILE = VagrantPlugins::Mountaineer::Projectfile
        REGISTRY    = VagrantPlugins::Mountaineer::Registry

        def initialize(app, env)
          @app     = app
          @machine = env[:machine]

          @config   = @machine.env.vagrantfile.config
          @registry = REGISTRY.new(@machine.env)
        end

        def call(env)
          load_projectfiles
          mount_projects

          @app.call(env)
        end

        private

        def load_projectfiles
          files_global  = @config.mountaineer.projectfiles
          files_machine = @machine.config.mountaineer.projectfiles
          files         = (files_global + files_machine).uniq

          files.each do |file|
            @registry.read_projectfile(PROJECTFILE.new(@machine.env, file))
          end
        end

        def mount_projects
          @registry.projects.each do |name, project|
            next if skip_mount?(project)

            @machine.config.vm.synced_folders[name] = project[:options].merge(
              disabled: false,
              guestpath: project[:guestpath],
              hostpath: project[:hostpath]
            )
          end
        end

        def skip_mount?(project)
          project.key?(:optional) &&
            project[:optional] == true &&
            !File.directory?(project[:hostpath])
        end
      end
    end
  end
end
