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

  test 'validates status is set automatically' do
    valid_item = items(:valid_item)
    valid_order_item = OrderItem.create(
      order_id: orders(:valid_pending_order).id,
      item_id: valid_item.id,
      department_id: valid_item.department.id
    )

    assert valid_order_item.valid?
  end

  test 'has_assembly? returns true when #assembly_id is present' do
    assert @valid_order_item_using_assembly.has_assembly?
  end

  test 'has_item? returns true when #item_id is present' do
    assert @valid_order_item_using_item.has_item?
  end
end
