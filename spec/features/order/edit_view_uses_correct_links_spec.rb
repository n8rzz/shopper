require 'rails_helper'

RSpec.feature 'order#edit view includes correct links' do
  let(:user) { create(:user) }
  let!(:order) { create(:order, :pending, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit edit_order_path(order.id)
  end

  it { expect(page).to have_link('Back', href: orders_path) }
  it { expect(page).to have_link('Show', href: order_path(order.id)) }
  it { expect(page).to have_link('Destroy') }
end
