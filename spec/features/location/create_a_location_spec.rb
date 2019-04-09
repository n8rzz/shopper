require 'rails_helper'

RSpec.feature 'Create an Location', js: true do
  let!(:location) { create(:location) }

  before :each do
    visit locations_path
    click_link 'New Location'
  end

  context 'when user clicks `New Location`' do
    it { expect(page).to have_no_css('mix-flyout_isHidden') }
    it { expect(page).to have_no_link('Destroy') }
  end

  context 'when a user fills in Location form' do
    before :each do
      fill_in 'Name', with: 'Icebox'
      fill_in 'City', with: 'Hell'
      fill_in 'State', with: 'TX'
      click_button 'Create Location'
    end

    it { expect(page).to have_text('Location was created successfully') }
    it { expect(page).to have_current_path(locations_path) }
    it { expect(page).to have_no_css('.mix-flyout_isHidden') }
  end
end
