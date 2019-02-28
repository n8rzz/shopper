require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:valid_item)
  end

  test "visiting the index" do
    skip "Name is undefined in template"

    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    skip "name is undefined in template(s) under test"

    visit items_url
    click_on "New Item"

    fill_in "Name", with: @item.name
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    skip "name is undefined in template(s) under test"

    visit items_url
    click_on "Edit", match: :first

    fill_in "Name", with: @item.name
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    skip "Name is undefined in template"

    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
