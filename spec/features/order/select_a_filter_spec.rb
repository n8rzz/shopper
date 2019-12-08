require 'rails_helper'

RSpec.feature 'Select a filter', js: true do
  let(:user) { create(:user) }
  let!(:pending_order) { create(:order, :pending, :with_order_items, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when loading #show' do
    before do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_link('Item') }
    it { expect(page).to have_link('Department') }
    it { expect(page).to have_link('Meal') }
  end

  context 'when a filter is clicked' do
    before do
      visit order_path(pending_order.id)
      click_link 'Meal'
    end

    it { expect(page.find(:css, '.mix-filterBar-link_isActive')).to have_text('Meal') }
  end
end
