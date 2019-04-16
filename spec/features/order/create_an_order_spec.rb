require 'rails_helper'

RSpec.feature 'Create an order', js: true do
  let!(:order) { create(:order, :pending) }

  # TODO: this should live somewhere else
  scenario 'visits new_order_path' do
    visit new_order_path

    expect(page).to have_text 'New Order'
    expect(page).to have_link 'Back'
    expect(page).to have_button 'Create Order'
  end

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
