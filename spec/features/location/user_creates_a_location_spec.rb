require 'rails_helper'

RSpec.feature 'User creates a Location' do
  scenario 'they see the Location on the page' do
    visit new_location_path

    fill_in 'Name', with: 'Icebox'
    fill_in 'City', with: 'Hell'
    fill_in 'State', with: 'TX'
    click_button 'Create Location'

    assert_text 'Location was successfully created'
  end
end
