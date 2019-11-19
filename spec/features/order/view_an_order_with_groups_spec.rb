require 'rails_helper'

RSpec.feature 'View an order with groups', js: true do
  let!(:item) { create(:item) }
  let!(:pending_order) { create(:order, :pending) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when a non-grouped item exists within an order' do
    before do
      visit items_path
      click_button 'Add to order'

      visit order_path(pending_order.id)
      click_link 'Meal'
    end

    it { expect(page).to have_text('Not Grouped') }
  end
end
