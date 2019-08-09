require 'rails_helper'

RSpec.feature 'Add item to an order with manual qty', js: true do
  let!(:pending_order) { create(:order, :pending) }
  let!(:item) { create(:item) }

  before :each do
    visit items_path

    fill_in "item-#{item.id}-qty", with: 3
    click_button 'Add to order'

    visit order_path(pending_order.id)
  end

  it { expect(page).to have_text('Qty: 3') }
  it { expect(page).to have_text(item.name) }
  it { expect(page).to have_text(item.department.name) }
end
