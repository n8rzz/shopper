require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it 'has a valid factory' do
    expect(build(:order_item)).to be_instance_of(OrderItem)
  end

  describe 'data and associations' do
    it { should have_db_column(:picked) }
    it { should have_db_column(:qty) }
    it { should belong_to(:order) }
    # it { should belong_to(:department) }
    # it { should belong_to(:items) }
    # it { should belong_to(:assembly) }
  end

  before do
    @order_item = build(:order_item)
  end

  subject { @order_item }

  describe 'validations' do
    it { should be_valid }
  end

  describe 'list_item_classnames' do
    context 'when #picked is false' do
      it 'returns the correct string' do
        expect(@order_item.list_item_classnames).to eq("orderItem js-orderItem-#{@order_item.id}")
      end
    end

    context 'when #picked is true' do
      before { @order_item.picked = true }

      it 'returns the correct string' do
        expect(@order_item.list_item_classnames).to eq("orderItem js-orderItem-#{@order_item.id} mix-orderItem_isPicked")
      end
    end
  end
end
