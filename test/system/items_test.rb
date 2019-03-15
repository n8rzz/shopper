require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:valid_item)
  end

  teardown do
    @item = nil
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "clicking an item at the index" do
    visit items_url
    click_on @item.name

    assert_current_path edit_item_path(@item.id)
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    fill_in "Name", with: "$Texas"
    select("Produce", from: "Department")
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating an Item" do
    visit items_url
    click_on @item.name

    fill_in "Name", with: "$Texas"
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  # test "destroying a Item" do
  #   visit items_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Item was successfully destroyed"
  # end

  test "add item to order" do
    visit items_url
    click_on "Add to order", match: :first

    assert_text "added to pending order"
  end
end
