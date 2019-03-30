require 'rails_helper'

RSpec.feature 'Add item with qty to an order' do
  let!(:order) { create(:order, :pending) }
  let!(:item) { create(:item) }

  before :each do
    visit items_path

    within first('.listItem') do
      fill_in 'Qty', with: 3
      click_button 'Add to order'
    end
  end

  it { expect(page).to have_text "#{item.name} added to pending order" }

  scenario 'Displays correct qty on order#show' do
    visit order_path(order.id)

    expect(page).to have_text('Qty: 3')
  end
end
