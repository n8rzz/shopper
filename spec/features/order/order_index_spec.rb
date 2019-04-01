require 'rails_helper'

RSpec.feature 'Order#index' do
  let!(:order) { create(:order, :pending) }

  before :each do
    visit orders_path
    click_link order.zero_padded_day
  end

  it { expect(page).to have_current_path(order_path(order.id)) }
end
