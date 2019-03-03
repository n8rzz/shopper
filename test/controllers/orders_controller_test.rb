require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_order = orders(:valid_pending_order)
  end

  teardown do
    @valid_order = nil
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { status: @valid_order.status, location_id: locations(:valid_location).id } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@valid_order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@valid_order), params: { order: { name: "#Texas" } }
    assert_redirected_to order_url(@valid_order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@valid_order)
    end

    assert_redirected_to orders_url
  end
end
