require 'rails_helper'

RSpec.feature 'Duplicate an order', js: true do
  let(:user) { create(:user) }
  let!(:complete_order) { create(:order, :complete, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'should not show duplicate link' do
    before do
      visit order_path(complete_order.id)
    end

    it { expect(page).to_not have_link('Duplicate') }
  end

  # context 'when an order is not pending status' do
  #   before do
  #     visit order_path(complete_order.id)

  #     click_link('Duplicate')
  #   end

  #   it { expect(page).to have_text('Order duplicated successfully') }
  # end
end
