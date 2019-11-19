require 'rails_helper'

RSpec.feature 'Follow link to item from order#show ', js: true do
  let!(:active_order) { create(:order, :with_order_items) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit order_path(active_order.id)
  end

  it { expect(page).to have_css('.orderItem-hd-link') }
  it { expect(page).to have_link(
    active_order.order_items.first.item.name,
    href: edit_item_path(active_order.order_items.first.item.id)
  ) }
end
