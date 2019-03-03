require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @valid_location = locations(:valid_location)
  end

  teardown do
    @valid_location = nil
  end

  test 'valid location' do
    assert @valid_location.valid?
  end

  test 'location name' do
    nameless_location = Location.create()

    refute nameless_location.valid?
  end

  test 'location uniqueness' do
    duplicate_location = Location.create(name: @valid_location.name)

    refute duplicate_location.valid?
  end
end
