require 'rails_helper'

RSpec.feature 'delete an order', js: true do
  let!(:order) { create(:order, :pending) }
  let(:user) { create(:user) }

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

  it { expect(page).to have_text('Order was successfully destroyed.') }
end
