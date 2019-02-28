require 'test_helper'

class AssemblyTest < ActiveSupport::TestCase
  def setup
    @valid_assembly = assemblies(:valid_assembly)
  end

  def teardown
    @valid_assembly = nil
  end

  test 'valid Assembly' do
    assert @valid_assembly.valid?
  end

  test 'validates name presence' do
    invalid_assembly = Assembly.create(name: '')

    refute invalid_assembly.valid? 'Assembly saved without a #name'
  end

  test 'validates unique name' do
    duplicate_assembly = Assembly.create(name: 'Beef Stew')

    refute duplicate_assembly.valid? 'Assembly saved with a duplicate #name'
  end
end
