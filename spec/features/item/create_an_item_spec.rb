require 'rails_helper'

RSpec.feature 'Create an Item', js: true do
  let(:department) { create(:department, name: 'Produce') }
  let!(:item) { create(:item, department: department) }

  before :each do
    visit items_path
    click_button 'New Item'
  end

  context 'when user clicks `New Item`' do
    it { expect(page).to have_no_css('mix-flyout_isHidden') }
    it { expect(page).to have_no_link('Destroy') }
    it { expect(page).to have_button('Create Item') }
  end

  context 'when a user fills in Item form' do
    before :each do
      fill_in 'Name', with: '$texas'
      select 'Produce', from: 'Department'

      click_button 'Create Item'
    end

    it { expect(page).to have_text('Item was created successfully') }
    it { expect(page).to have_current_path(items_path) }
    it { expect(page).to have_css('.mix-flyout_isHidden') }
  end
end
