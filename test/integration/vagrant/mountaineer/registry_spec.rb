require_relative '../../../spec_helper'

describe VagrantPlugins::Mountaineer::Registry do
  projectfile = VagrantPlugins::Mountaineer::ProjectFile

  describe 'project definition' do
    it 'allows defining projects' do
      path = File.expand_path(File.join(File.dirname(__FILE__),
                                        '../../fixtures/projectfiles/',
                                        'simple'))

      file     = projectfile.new({}, path)
      registry = described_class.new({})

      registry.read_projectfile(file)

      expect(registry.projects['foo']).to eq({:bar => 'baz'})
    end
  end
end
