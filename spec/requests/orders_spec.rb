require "rails_helper"

RSpec.describe "Order", :type => :request do
  context 'Post #duplicate' do
    let(:complete_order) { create(:order, :complete) }

    context 'when a pending order already exists' do
      let!(:pending_order) { create(:order, :pending) }

      before :each do
        post "/orders/#{complete_order.id}/duplicate"
      end

      it { expect(response).to redirect_to "/orders/#{complete_order.id}/edit" }
    end

    context 'when no pending orders exist' do
      before :each do
        post "/orders/#{complete_order.id}/duplicate"
      end

      it { expect(response).to redirect_to "/orders/#{Order.last.id}/edit" }
      it { expect(flash[:notice]).to match(/^Order duplicated successfully/) }
    end
  end
end
