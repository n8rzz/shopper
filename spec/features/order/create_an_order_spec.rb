require 'rails_helper'

RSpec.feature 'Create an order', js: true do
  let!(:order) { create(:order, :pending) }

  context 'when #shopping_date is not filled in' do
    before :each do
      visit new_order_path

      select 'active', from: 'Status'

      click_button 'Create Order'
    end

    it { expect(page).to have_text('Order was created successfully') }
    it { expect(page).to have_current_path(orders_path) }
  end

  context 'when #shopping_date is filled in' do
    before :each do
      visit new_order_path

      select 'active', from: 'Status'
      fill_in 'order_shopping_date', with: Time.now

      click_button 'Create Order'
    end

    it { expect(page).to have_text('Order was created successfully') }
    it { expect(page).to have_current_path(orders_path) }
  end
end
