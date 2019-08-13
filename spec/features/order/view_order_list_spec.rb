require 'rails_helper'

RSpec.feature 'Order#index', js: true do
  let!(:order) { create(:order, :pending) }

  context 'visits order#index' do
    before :each do
      visit new_order_path
    end

    it { expect(page).to have_text('New Order') }
    it { expect(page).to have_link('Back') }
    it { expect(page).to have_button('Create Order') }
  end
end
