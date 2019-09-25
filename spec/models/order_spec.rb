require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(build(:order)).to be_instance_of(Order)
    expect(build(:order, :pending)).to be_instance_of(Order)
    expect(build(:order, :cancelled)).to be_instance_of(Order)
    expect(build(:order, :complete)).to be_instance_of(Order)
    expect(build(:order, :with_order_items)).to be_instance_of(Order)
  end

  describe 'data and associations' do
    # it { should belong_to(:location) }
    it { should have_many(:items) }
    it { should have_many(:order_items) }
    it { should have_many(:assemblies) }
    it { should have_many(:departments) }
    it { should have_db_column(:shopping_date) }
  end

  before do
    @order = build(:order)
  end

  subject { @order }

  describe 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:shopping_date) }
  end

  describe '.duplicate' do
    context 'when no pending order exists' do
      let(:complete_order) { create(:order, :complete, :with_order_items) }

      subject { complete_order.duplicate }

      it { expect(subject).to be_instance_of Order }
      it { expect(subject.location_id).to eq complete_order.location_id }
      it { expect(subject.order_items.size).to eq complete_order.order_items.size }
    end

    # context 'when a pending order exists' do
    #   let!(:pending_order) { create(:order, :pending, :with_order_items) }
    #   let!(:complete_order) { create(:order, :complete, :with_order_items) }

    #   subject { complete_order.duplicate }

    #   it { expect(subject).to eq nil }
    # end
  end

  describe '.live?' do
    let!(:pending_order) { create(:order, :pending) }
    let!(:active_order) { create(:order) }
    let!(:complete_order) { create(:order, :complete) }

    it { expect(pending_order.live?).to eq true }
    it { expect(active_order.live?).to eq true }
    it { expect(complete_order.live?).to eq false }
  end

  describe '.delete_assembly' do
    let!(:active_order) { create(:order, :with_order_items) }
    # let!(:complete_order) { create(:order, :complete, :with_order_items) }

    context 'when order_items exist for an assembly_id' do
      subject { active_order.delete_assembly(active_order.order_items.first.id) }

      # TODO: this feels like the wrong assertion here
      it { expect(subject).not_to eq false }
    end

    # context 'when order_items do not exist for an assembly_id' do
    #   subject { active_order.delete_assembly(42) }

    #   it { expect(subject).to eq nil }
    # end

    # context 'when order#status is not live' do
    #   subject { complete_order.delete_assembly(complete_order.order_items.first.id) }

    #   it { expect(subject).to eq nil }
    #   it { expect(complete_order.order_items.length).to eq 1 }
    # end
  end
end
