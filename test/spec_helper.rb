if ENV.key?('TRAVIS_COVERAGE') && 'true' == ENV['TRAVIS_COVERAGE']
  require 'coveralls'
  Coveralls.wear!
end

require 'vagrant/mountaineer'

require_relative './helpers/ui'
