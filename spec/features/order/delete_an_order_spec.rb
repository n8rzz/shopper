require 'rails_helper'

RSpec.feature 'delete an order', js: true do
  let(:user) { create(:user) }
  let!(:order) { create(:order, :pending, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit order_path(order.id)

    accept_alert do
      click_link('Destroy')
    end
  end

  it { expect(page).to have_selector('.js-notice', text: 'Order was successfully destroyed.') }
end
