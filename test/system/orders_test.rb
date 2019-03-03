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

  test "clicking an order at the index" do
    # skip "undefined method `name` in #show template"
    visit orders_url
    click_on @order.id

    assert_current_path order_path(@order.id)
  end

  test "remove button present on #show" do
    visit orders_url
    click_on @order.id
    assert_selector "button", text: "Remove"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    select("pending", from: "Status")
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    select("active", from: "Status")
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
