require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @valid_location = locations(:valid_location)
  end

  test "visiting the index" do
    visit locations_url
    assert_selector "h1", text: "Locations"
  end

  test "clicking a location at the index" do
    visit locations_url
    click_on @valid_location.name

    assert_current_path edit_location_path(@valid_location.id)
  end

  test "creating a Location" do
    visit locations_url
    click_on "New Location"

    fill_in "City", with: @valid_location.city
    fill_in "Name", with: Faker::Company.name
    fill_in "State", with: @valid_location.state
    click_on "Create Location"

    assert_text "Location was successfully created"
  end

  test "updating a Location" do
    visit locations_url
    click_on @valid_location.name

    fill_in "City", with: @valid_location.city
    fill_in "Name", with: @valid_location.name
    fill_in "State", with: @valid_location.state
    click_on "Update Location"

    assert_text "Location was successfully updated"
  end

  test "destroying a Location" do
    visit locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Location was successfully destroyed"
  end
end
