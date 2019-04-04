require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it 'has a valid factory' do
    expect(build(:order_item)).to be_instance_of(OrderItem)
  end

  describe 'data and associations' do
    it { should have_db_column(:picked) }
    it { should have_db_column(:qty) }
    it { should belong_to(:order) }
    it { should belong_to(:department).optional }
    it { should belong_to(:item).optional }
    it { should belong_to(:assembly).optional }
  end

  subject { build(:order_item) }

  describe 'validations' do
    it { should be_valid }
  end

  describe 'list_item_classnames' do
    context 'when #picked is false' do
      it 'returns the correct string' do
        expect(subject.list_item_classnames).to eq("orderItem js-orderItem-#{subject.id}")
      end
    end

    context 'when #picked is true' do
      before { subject.picked = true }

      it 'returns the correct string' do
        expect(subject.list_item_classnames).to eq("orderItem js-orderItem-#{subject.id} mix-orderItem_isPicked")
      end
    end
  end

  describe '.duplicate' do
    let!(:order) { create(:order, :pending) }
    let!(:order_item) { create(:order_item) }

    subject { order_item.duplicate(order.id) }

    it { expect(subject).to be_instance_of OrderItem }
    it { expect(subject.order_id).to eq order.id }
    it { expect(subject.assembly_id).to eq order_item.assembly_id }
    it { expect(subject.item_id).to eq order_item.item.id }
    it { expect(subject.picked).to eq order_item.picked }
    it { expect(subject.department_id).to eq order_item.department_id }
    it { expect(subject.qty).to eq order_item.qty }
  end
end
