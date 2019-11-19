require 'rails_helper'

RSpec.feature 'mark order item as picked', js: true do
  let!(:order) { create(:order, :pending, :with_order_items) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit order_path(order.id)
  end

  context 'when Item filter is active' do
    before :each do
      find('.js-orderItem-action', visible: false).click
    end

    it { expect(page).to have_css('.mix-orderItem_isPicked') }
  end

  context 'when Department filter is active' do
    before :each do
      click_link('Department')
      find('.js-orderItem-action').click
    end

    it { expect(page).to have_css('.mix-orderItem_isPicked') }
  end

  context 'when Department filter is active' do
    before :each do
      click_link('Meal')
      find('.js-orderItem-action').click
    end

    it { expect(page).to have_css('.mix-orderItem_isPicked') }
  end
end
