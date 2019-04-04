require 'rails_helper'

RSpec.feature 'Duplicate an order' do
  let!(:complete_order) { create(:order, :complete) }

  context 'when an order is not pending status' do
    before do
      visit order_path(complete_order.id)
      click_link('Duplicate')
    end

    it { expect(page).to have_text('Order duplicated successfully') }
  end
end
