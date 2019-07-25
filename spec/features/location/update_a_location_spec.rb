require 'rails_helper'

RSpec.feature 'Update a Location', js: true do
  let!(:location) { create(:location) }

  scenario ':edit template has correct links' do
    visit locations_path
    click_link location.name

    expect(page).to have_text 'Editing Location'
    expect(page).to have_link 'Back', href: locations_path
    expect(page).to have_link 'New Location', href: new_location_path
    expect(page).to have_button 'Update Location'
  end

  scenario 'location updatescorrectly' do
    visit locations_path
    click_on location.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Location'

    expect(page).to have_text 'Location was updated successfully'
    expect(page).to have_current_path(locations_path)
  end
end
