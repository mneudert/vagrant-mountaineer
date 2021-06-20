# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vagrant/mountaineer/synopsis'
require 'vagrant/mountaineer/version'

Gem::Specification.new do |spec|
  spec.name     = 'vagrant-mountaineer'
  spec.version  = VagrantPlugins::Mountaineer::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors  = ['Marc Neudert']
  spec.email    = ['marc.neudert@gmail.com']

  # roughly tracking ruby included in the installer package
  # https://github.com/hashicorp/vagrant-installers/blob/main/substrate/run.sh
  spec.required_ruby_version     = '~> 2.4'
  spec.required_rubygems_version = '>= 1.3.6'

  spec.summary     = VagrantPlugins::Mountaineer::SYNOPSIS
  spec.description = 'Vagrant plugin to mount projects specified'\
                     ' in a Projectfile to one of your vagrant boxes'
  spec.homepage    = 'https://github.com/mneudert/vagrant-mountaineer'
  spec.license     = 'MIT'

  spec.files  = Dir.glob('lib/**/*')
  spec.files += Dir.glob('locales/**/*')
  spec.files += %w[CHANGELOG.md LICENSE.txt README.md]

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org' if spec.respond_to?(:metadata)

  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.12.0'
end
