require 'rails_helper'

RSpec.feature 'Select a filter', js: true do
  let!(:pending_order) { create(:order, :pending) }

  context 'when loading #show' do
    before do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_link('Item', href: order_path(pending_order.id)) }
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
