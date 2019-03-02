require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_item = items(:valid_item)
  end

  test "should post create" do
    post order_items_create_url, params: { order_item: { item_id: @valid_item.id } }
    assert_redirected_to items_path
  end
end
