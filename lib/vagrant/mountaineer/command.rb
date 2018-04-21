module VagrantPlugins
  module Mountaineer
    # Defines the mountaineer command
    class Command < Vagrant.plugin(2, :command)
      HOOK_PROJECTS = VagrantPlugins::Mountaineer::Action::HookProjects
      UTIL          = VagrantPlugins::Mountaineer::Util

      def self.synopsis
        'mountaineer utility commands'
      end

      def execute
        send(select_command(@argv))
      end

      private

      def display_help
        @env.ui.info('Available commands:')
        @env.ui.info('  - help')
        @env.ui.info('  - info')
      end

      def display_info
        first_vm = true

        with_target_vms do |vm|
          vm.action_raw(:mountaineer_command, HOOK_PROJECTS)

          vm.env.ui.info("Machine: #{vm.name}")
          display_machine_mounts(vm)

          vm.env.ui.info('') if first_vm

          first_vm = false
        end
      end

      def display_machine_mounts(machine)
        mounts = get_machine_mounts(machine)
        pad_to = UTIL.pad_to(mounts)

        mounts.each do |guestpath, hostpath|
          guestpath = guestpath.ljust(pad_to)
          hostpath  = Pathname.new(machine.env.root_path) + hostpath

          machine.env.ui.info(" - #{guestpath} (Host: #{hostpath})")
        end
      end

      def get_machine_mounts(machine)
        machine.config.vm.synced_folders.sort.map do |_name, sf|
          [sf[:guestpath], sf[:hostpath]]
        end.to_h
      end

      def select_command(argv)
        case argv[0]
        when 'help' then :display_help
        when 'info' then :display_info
        else :display_help
        end
      end
    end
  end
end
