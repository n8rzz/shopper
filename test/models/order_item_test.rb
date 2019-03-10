require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  setup do
    @valid_order_item_using_assembly = order_items(:valid_order_item_using_assembly)
    @valid_order_item_using_item = order_items(:valid_order_item_using_item)
  end

  teardown do
    @valid_order_item_using_assembly = nil
    @valid_order_item_using_item = nil
  end

  test 'valid OrderItem with only assembly' do
    assert @valid_order_item_using_assembly.valid?
  end

  test 'valid OrderItem with only item' do
    assert @valid_order_item_using_item.valid?
  end
end
