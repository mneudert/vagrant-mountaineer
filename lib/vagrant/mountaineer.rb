require 'vagrant'

I18n.load_path << File.expand_path('../../../locales/en.yml', __FILE__)
I18n.reload!

require 'vagrant/mountaineer/synopsis'
require 'vagrant/mountaineer/version'

require 'vagrant/mountaineer/project_file'
require 'vagrant/mountaineer/util'

require 'vagrant/mountaineer/action'
require 'vagrant/mountaineer/action/hook_projects'
require 'vagrant/mountaineer/config'
require 'vagrant/mountaineer/plugin'
require 'vagrant/mountaineer/registry'
