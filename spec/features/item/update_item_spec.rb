require 'rails_helper'

RSpec.feature 'Update an Item', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let!(:item) { create(:item, department: department, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'visit item#edit' do
    before :each do
      visit items_path
      click_link(item.name)
    end

    it { expect(page).to have_text('Editing Item') }
    it { expect(page).to have_link('Back', href: items_path) }
    it { expect(page).to have_button('Update Item') }
  end

  context 'the item updates are displayed' do
    before :each do
      visit items_path
      click_on(item.name)

      fill_in 'Name', with: '$texas'
      click_button('Update Item')
    end

    it { expect(page).to have_text('Item was updated successfully') }
    it { expect(page).to have_current_path(items_path) }
  end
end
