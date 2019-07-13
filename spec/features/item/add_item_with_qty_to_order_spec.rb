# require 'rails_helper'

# RSpec.feature 'Add item with manual qty to an order', js: true do
#   let!(:order) { create(:order, :pending) }
#   let!(:item) { create(:item) }

#   before :each do
#     visit items_path

#     fill_in "item-#{item.id}-qty", with: 3
#     find(".js-stepper-submit-#{item.id}").click
#   end

#   it { expect(page).to have_text "#{item.name} added to pending order" }

#   scenario 'Displays correct qty on order#show' do
#     visit order_path(order.id)

#     expect(page).to have_text('Qty: 3')
#   end
# end
