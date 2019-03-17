require 'rails_helper'

RSpec.feature 'Create an order' do
  let!(:order) { create(:order, :pending) }

  scenario 'visits new_order_path' do
    visit new_order_path

    expect(page).to have_text 'New Order'
    expect(page).to have_link 'Back'
    expect(page).to have_button 'Create Order'
  end

  scenario 'adds a new order' do
    visit new_order_path

    select 'active', from: 'Status'
    click_button 'Create Order'

    expect(page).to have_text 'Order was created successfully'
    expect(page).to have_current_path(orders_path)
  end
end
