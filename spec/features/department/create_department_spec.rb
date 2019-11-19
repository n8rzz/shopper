require 'rails_helper'

RSpec.feature 'Create an Department', js: true do
  let!(:department) { create(:department) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when user clicks `New Department`' do
    before :each do
      visit departments_path
      click_link 'New Department'
    end

    it { expect(page).to have_no_css('mix-flyout_isHidden') }
    it { expect(page).to have_no_link('Destroy') }
  end

  context 'when a user fills in Department form' do
    before :each do
      visit departments_path
      find('a.js-flyout-trigger').click

      fill_in 'Name', with: 'Icebox'
      click_button 'Create Department'
    end

    it { expect(page).to have_text('Department was created successfully') }
    it { expect(page).to have_current_path(departments_path) }
  end
end

