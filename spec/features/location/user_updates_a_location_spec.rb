require 'rails_helper'

RSpec.feature 'User updates a Location' do
  let!(:location) { create(:location) }

  scenario 'visit location#edit' do
    visit '/locations'
    click_link location.name

    expect(page).to have_text 'Editing Location'
    expect(page).to have_link 'Back', href: locations_path
    expect(page).to have_button 'Update Location'
  end

  scenario 'They see the location updates on the page' do
    visit locations_path
    click_on location.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Location'

    expect(page).to have_text 'Location was updated successfully'
    expect(page).to have_current_path(locations_path)
  end
end
