require 'rails_helper'

RSpec.feature 'Delete order_item from order', js: true do
  let(:user) { create(:user) }
  let!(:pending_order) { create(:order, :pending, :with_order_items, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit order_path(pending_order.id)

    within ".js-orderItem-#{pending_order.order_items.first.id}" do
      find('.js-orderItem-remove').click()
    end
  end

  # context 'an order_item is removed from an order' do
  #   it { expect(page).to have_no_text(pending_order.order_items.first.item.name) }
  # end

  context 'progress bar totalCount' do
    it { expect(find('.js-progress-currentCount')).to have_text('0') }
  end
end
