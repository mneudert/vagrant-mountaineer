# Vagrant Mountaineer

Mounts projects from a Projectfile.

__This plugin is experimental and may change unexpectedly.__

## Usage

### Vagrant Configuration

The plugin becomes active once you hook one or more projectfiles into your `Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  config.mountaineer.projectfiles = [
    'primary.projectfile',
    'secondary.projectfile'
  ]
end
```

This will look for project definitions in two files (`primary.projectfile` and `secondary.projectfile`). All paths will be expanded by prefixing the vagrant root directory (where your `Vagrantfile` resides) or taken as is if absolute.

### Project Definition

Defining a project to be mounted is done by adding its definition to your projectfile:

```ruby
project 'lib',
    guestpath: '/data/plugin-lib',
    hostpath: './lib'

project 'test_nfs',
    guestpath: '/data/plugin-test',
    hostpath: './test',
    options: {
      type: :nfs
    }

project 'optional',
    guestpath: '/data/plugin-optional',
    hostpath: './may-not-exist',
    optional: true
```

Values for `:guestpath ` and `:hostpath` are required. Additional options (like `type`) can be configuring using the `:options` key. The name of the project will be used as the mount identifier.

If a project is defined as `optional` it will not be mounted if the host path is missing. For the time being this is done silently.

### Mountpoint Listing

You can list all known mountpoints in all machines:

```shell
vagrant mountaineer info
```

## Development

You can always install the plugin directly from source:

```shell
gem build vagrant-mountaineer.gemspec

vagrant plugin uninstall vagrant-mountaineer
vagrant plugin install vagrant-mountaineer-x.x.x.dev.gem
```

## License

Licensed under the [MIT license](http://opensource.org/licenses/MIT).
