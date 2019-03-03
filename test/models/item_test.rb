require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
    @valid_item = items(:valid_item)
  end

  teardown do
    @valid_item = nil
  end

  test 'valid item' do
    assert @valid_item.valid?
  end

  test 'item name' do
    nameless_item = Item.create()

    refute nameless_item.valid?
  end

  test 'item without department' do
    invalid_item = Item.create(name: 'Avacado')

    refute invalid_item.valid? 'Saved Item without Department association'
  end

  test 'item uniqueness' do
    duplicate_item = Item.create(name: 'Carrot')

    refute duplicate_item.valid? 'Saved duplicate Item name'
  end
end
