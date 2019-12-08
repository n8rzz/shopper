require 'rails_helper'

RSpec.feature 'Follow link to item from order#show ', js: true do
  let(:user) { create(:user) }
  let!(:active_order) { create(:order, :with_order_items, ownable: user) }

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
