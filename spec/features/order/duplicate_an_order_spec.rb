require 'rails_helper'

RSpec.feature 'Duplicate an order', js: true do
  let!(:complete_order) { create(:order, :complete) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when an order is not pending status' do
    before do
      visit order_path(complete_order.id)
      click_link('Duplicate')
    end

    it { expect(page).to have_text('Order duplicated successfully') }
  end
end
