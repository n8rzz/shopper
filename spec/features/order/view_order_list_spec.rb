require 'rails_helper'

RSpec.feature 'Order#index', js: true do
  let(:user) { create(:user) }
  let!(:order) { create(:order, :pending, ownable: user) }
  let!(:completed_orders) { create_list(:order, 10, :complete, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'visits order#index' do
    before :each do
      visit orders_path
    end

    it { expect(page).to have_text('Orders') }
    it { expect(page).to have_link('New Order') }
    it { expect(page).to have_button('View More') }
  end
end
