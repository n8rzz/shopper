require 'rails_helper'

RSpec.feature 'order#show includes the correct links', js: true do
  let(:user) { create(:user) }
  let!(:pending_order) { create(:order, :pending, ownable: user) }
  let!(:complete_order) { create(:order, :complete, :with_order_items, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when an order has pending status' do
    before :each do
      visit order_path(pending_order.id)
    end

    it { expect(page).to have_link('Back') }
    it { expect(page).to have_link('Edit') }
    it { expect(page).to have_no_link('Duplicate')}
    it { expect(page).to have_link('Destroy') }
    it { expect(page).to have_link('Item') }
    it { expect(page).to have_link('Department') }
    it { expect(page).to have_link('Meal') }
    it { expect(page).to have_text('Shopping Date: ') }
    it { expect(page).to have_text("Status: #{pending_order.status}") }
  end

  context 'when an order is not pending status' do
    before :each do
      visit order_path(complete_order.id)
    end

    it { expect(page).to_not have_link('Duplicate') }
    it { expect(page).to have_no_link('Delete') }
  end
end
