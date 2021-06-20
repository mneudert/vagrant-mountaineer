# frozen_string_literal: true

require_relative '../../../spec_helper'

describe VagrantPlugins::Mountaineer::Registry do
  projectfile = VagrantPlugins::Mountaineer::Projectfile

  describe 'project definition' do
    it 'allows defining projects' do
      path = File.expand_path(File.join(File.dirname(__FILE__),
                                        '../../fixtures/projectfiles/',
                                        'simple'))

      file     = projectfile.new({}, path)
      registry = described_class.new({})

      registry.read_projectfile(file)

      expect(registry.projects['foo']).to be_a(Hash)
    end
  end

  describe 'defined projects require valid/complete options' do
    it 'ignores incomplete/wrong options' do
      env  = Vagrant::Environment.new(ui_class: Helpers::UI::Tangible)
      path = File.expand_path(File.join(File.dirname(__FILE__),
                                        '../../fixtures/projectfiles/',
                                        'invalid-options'))

      file     = projectfile.new(env, path)
      registry = described_class.new(env)

      registry.read_projectfile(file)

      messages = env.ui.messages.map { |m| m[:message] }.join("\n")

      expect(messages).to match(/missing-guestpath.+\n.+ignored/i)
      expect(messages).to match(/missing-hostpath.+\n.+ignored/i)
      expect(messages).to match(/empty-guestpath.+\n.+ignored/i)
      expect(messages).to match(/empty-hostpath.+\n.+ignored/i)
    end
  end
end
