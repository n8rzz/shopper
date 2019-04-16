require 'rails_helper'

RSpec.feature 'Delete meal and items from order', js: true do
  let!(:pending_order) { create(:order, :pending, :with_order_items) }
  let!(:complete_order) { create(:order, :complete, :with_order_items) }

  context 'when an order is live' do
    it 'removes meal from view' do
      visit order_path(pending_order.id)
      click_link('Meal')

      accept_confirm do
        click_link('Delete')
      end

      expect(page).to have_no_text(pending_order.order_items.first.item.name)
      expect(page).to have_current_path("/orders/#{pending_order.id}?order=assembly")
    end
  end

  context 'when an order is not live' do
    it 'no Delete link is present' do
      visit order_path(complete_order.id)

      expect(page).to have_no_link('Delete')
    end
  end
end
