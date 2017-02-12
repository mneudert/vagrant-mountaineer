require_relative '../../spec_helper'

describe VagrantPlugins::Mountaineer::ProjectFile do
  it 'locates absolute project files' do
    file = described_class.new({}, __FILE__)

    expect(file.exist?).to be(true)
  end

  it 'locates relative project files' do
    env  = OpenStruct.new(root_path: Pathname.new(File.dirname(__FILE__)))
    file = described_class.new(env, File.basename(__FILE__))

    expect(file.exist?).to be(true)
  end

  it 'fails to locate not existing absolute project files' do
    path = File.dirname(__FILE__) + '/does-not-exist'
    file = described_class.new({}, path)

    expect(file.exist?).to be(false)
  end

  it 'fails to locate not existing relative project files' do
    env  = OpenStruct.new(root_path: Pathname.new(File.dirname(__FILE__)))
    file = described_class.new(env, 'does-not-exist')

    expect(file.exist?).to be(false)
  end
end
