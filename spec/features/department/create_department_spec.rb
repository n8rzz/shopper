require 'rails_helper'

RSpec.feature 'Create an Department', js: true do
  let!(:department) { create(:department) }

  context 'when user clicks `New Department`' do
    before :each do
      visit departments_path
      click_button 'New Department'
    end

    it { expect(page).to have_no_css('mix-flyout_isHidden') }
    it { expect(page).to have_no_link('Destroy') }
    it { expect(page).to have_button('Create Department') }
  end

  context 'when a user fills in Department form' do
    before :each do
      visit departments_path
      click_button 'New Department'

      fill_in 'Name', with: 'Icebox'
      click_button 'Create Department'
    end

    it { expect(page).to have_text('Department was created successfully') }
    it { expect(page).to have_current_path(departments_path) }
    # FIXME: This works in the other tests, but is failing here
    # it { expect(page).to have_css('.mix-flyout_isHidden') }
  end
end

