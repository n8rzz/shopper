require 'rails_helper'

# TODO: re-implement delete via ui component
# see: [#21](https://github.com/n8rzz/shopper/issues/21)
# RSpec.feature 'Delete meal and items from order', js: true do
#   let!(:pending_order) { create(:order, :pending, :with_order_items) }
#   let!(:complete_order) { create(:order, :complete, :with_order_items) }
#   let(:user) { create(:user) }

#     before do
#       sign_in user
#     end

#     after do
#       sign_out user
#     end

#   context 'when an order is live' do
#     before :each do
#       visit order_path(pending_order.id)
#       click_link('Meal')

#       accept_confirm do
#         click_link('Delete')
#       end
#     end

#     it { expect(page).to have_no_text(pending_order.order_items.first.item.name) }
#     it { expect(page).to have_current_path("/orders/#{pending_order.id}?order=assembly") }
#   end

#   context 'when an order is not live' do
#     before :each do
#       visit order_path(complete_order.id)
#       click_link('Meal')
#     end

#     it { expect(page).to have_no_link('Delete') }
#   end
# end
