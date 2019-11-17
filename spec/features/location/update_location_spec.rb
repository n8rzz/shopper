require 'rails_helper'

RSpec.feature 'Update a Location', js: true do
  let!(:location) { create(:location) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario '#edit template has correct links' do
    visit locations_path
    click_link location.name

    expect(page).to have_text('Edit Location')
    expect(page).to have_link('Back', href: locations_path)
    expect(page).to have_link('New', href: new_location_path)
    expect(page).to have_button('Update Location')
  end

  scenario 'location updates correctly' do
    visit locations_path
    click_on location.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Location'

    expect(page).to have_text('Location was updated successfully')
    expect(page).to have_text('$texas')
    expect(page).to have_current_path(locations_path)
  end
end
