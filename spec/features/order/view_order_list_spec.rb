require 'rails_helper'

RSpec.feature 'Order#index', js: true do
  let!(:order) { create(:order, :pending) }
  let!(:completed_orders) { create_list(:order, 5, :complete) }

  context 'visits order#index' do
    before :each do
      visit orders_path
    end

    it { expect(page).to have_text('Orders') }
    it { expect(page).to have_link('New Order') }
    # it { expect(page).to have_button('View More') }
  end
end
