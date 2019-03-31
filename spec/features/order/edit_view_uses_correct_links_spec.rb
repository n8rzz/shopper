require 'rails_helper'

RSpec.feature 'Edit view uses correct links' do
  let!(:order) { create(:order, :pending) }

  before :each do
    visit edit_order_path(order.id)
  end

  it { expect(page).to have_link('Back', href: orders_path) }
  it { expect(page).to have_link('Show', href: order_path(order.id)) }
  it { expect(page).to have_link('Destroy') }
end