require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_order_item = order_items(:valid_order_item_using_item)
  end

  test "should create order_item with item" do
    valid_item = items(:valid_item)

    assert_difference('OrderItem.count') do
      post "/order_items/create", params: { order_item: { item_id: valid_item.id, status: 'open' } }
    end

    assert_redirected_to items_url
  end

  test "should create order_item with assembly" do
    valid_assembly = assemblies(:valid_assembly)

    assert_difference('OrderItem.count') do
      post "/order_items/create", params: { order_item: { assembly_id: valid_assembly.id, status: 'open' } }
    end

    assert_redirected_to assemblies_url
  end

  test "should destroy order_item" do
    skip "no fixture found"

    assert_difference('OrderItem.count', -1) do
      delete order_items(@valid_order_item)
    end

    assert_redirected_to orders_url
  end
end
