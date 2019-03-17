require 'rails_helper'

RSpec.feature 'Create a Location' do
  before do
    visit new_location_path
  end

  context 'when visiting new_location_path' do
    it 'destroy button does not display' do
      expect(page).to have_no_button('Destroy')
    end
  end

  it 'creates a new Location' do
    fill_in 'Name', with: 'Icebox'
    fill_in 'City', with: 'Hell'
    fill_in 'State', with: 'TX'
    click_button 'Create Location'

    expect(page).to have_text('Location was created successfully')
  end
end
