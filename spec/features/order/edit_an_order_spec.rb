require 'rails_helper'

RSpec.feature 'Edit an order', js: true do
  let!(:order) { create(:order, :pending) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit edit_order_path(order.id)

    select 'active', from: 'Status'

    click_button('Update Order')
  end

  it { expect(page).to have_text('Order was updated successfully') }
end
