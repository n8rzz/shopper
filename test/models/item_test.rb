require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @valid_item = items(:valid_item)
  end

  def teardown
    @valid_item = nil
  end

  test 'valid item' do
    assert @valid_item.valid?
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
