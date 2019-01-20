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

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  end

  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.63'
end
