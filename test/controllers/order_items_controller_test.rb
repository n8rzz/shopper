require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_order_item = order_items(:valid_order_item)
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete order_item_url(@valid_order_item)
    end

    assert_redirected_to items_url
  end
end
