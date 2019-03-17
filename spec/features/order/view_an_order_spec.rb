require 'rails_helper'

RSpec.feature 'View an order' do
  let!(:order) { create(:order, :pending) }

  scenario 'and clicks an order at order#index' do
    visit orders_path

    click_link order.zero_padded_day

    expect(page).to have_current_path(order_path(order.id))
  end

  # scenario 'and visits order#show' do
  #   visit order_path(order.id)

  #   within ".js-orderItem-#{order.order_items.first.id}" do
  #     expect(page).to have_text order.order_items.first.name
  #   end
  # end
end
