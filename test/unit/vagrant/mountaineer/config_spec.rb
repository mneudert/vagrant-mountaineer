# frozen_string_literal: true

require 'ostruct'
require_relative '../../../spec_helper'

describe VagrantPlugins::Mountaineer::Config do
  describe 'validating configuration' do
    it 'finds missing project files' do
      config  = described_class.new
      machine = Struct.new(:env).new(Struct.new(:root_path).new('.'))

      config.projectfiles = [
        File.join(File.dirname(__FILE__), 'does-not-exist')
      ]

      result = config.validate(machine)
      errors = result['Mountaineer configuration']

      expect(errors[0]).to match(/not found.+#{config.projectfiles[0]}/i)
    end
  end
end
