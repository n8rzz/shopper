require 'rails_helper'

RSpec.feature 'View an order' do
  let!(:order) { create(:order, :pending) }

  scenario 'and clicks an order at order#index' do
    visit orders_path

    click_link order.zero_padded_day

    expect(page).to have_current_path(order_path(order.id))
  end

  scenario 'and views a single order' do
    visit order_path(order.id)

    expect(page).to have_link 'Back'
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Destroy'
    expect(page).to have_link 'Item'
    expect(page).to have_link 'Department'
    expect(page).to have_link 'Meal'
  end

  # scenario 'and visits order#show' do
  #   visit order_path(order.id)

  #   using_wait_time 10 do
  #     within ".js-orderItem-#{order.order_items.first.id}" do
  #       expect(page).to have_text order.order_items.first.name
  #     end
  #   end
  # end
end
