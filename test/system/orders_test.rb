require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:valid_pending_item_order)
  end

  teardown do
    @order = nil
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  # test "clicking an order at the index" do
  #   visit orders_url
  #   click_on @order.location.name, match: first
  #   assert_current_path order_path(@order.location.name)
  # end

  # test "edit link present at the index" do
  #   visit orders_url
  #   assert_selector "a", text: "Edit"
  # end

  # test "remove button present on #show" do
  #   visit orders_url
  #   click_on @order.location.name, match: first
  #   assert_selector "button", text: "Destroy"
  # end

  # test "edit link present on #show" do
  #   visit orders_url
  #   click_on @order.location.name, match: first
  #   assert_selector "a", text: "Edit"
  # end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    select("pending", from: " Status")
    select(locations(:valid_location).name, from: "Location")
    click_on "Create Order"

    assert_text "Order was successfully created"
  end

  test "destroying a Order" do
    skip "need order.id"
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
