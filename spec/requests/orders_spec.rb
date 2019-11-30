require "rails_helper"

RSpec.describe "Order", :type => :request do
  before do
    sign_in create(:user)
  end

  # TODO: re-implement via: https://github.com/n8rzz/shopper/issues/314
  # context 'Post #duplicate' do
  #   let(:complete_order) { create(:order, :complete) }

  #   context 'when a pending order already exists' do
  #     let!(:pending_order) { create(:order, :pending) }

  #     before :each do
  #       post "/orders/#{complete_order.id}/duplicate"
  #     end

  #     it { expect(response).to redirect_to "/orders/#{complete_order.id}/edit" }
  #   end

  #   context 'when no pending orders exist' do
  #     before :each do
  #       post "/orders/#{complete_order.id}/duplicate"
  #     end

  #     it { expect(response).to redirect_to "/orders/#{Order.last.id}/edit" }
  #     it { expect(flash[:notice]).to match(/^Order duplicated successfully/) }
  #   end
  # end

  context 'Post #delete_assembly' do
    let(:active_order) { create(:order, :with_order_items) }

    context 'when an assembly exists' do
      before :each do
        delete order_assembly_path(active_order.id, active_order.order_items.first.assembly_id)
      end

      it { expect(response).to redirect_to "/orders/#{active_order.id}?order=assembly" }
      it { expect(flash[:notice]).to match(/^Assembly deleted successfully/) }
    end
  end
end
