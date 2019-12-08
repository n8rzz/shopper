require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'has a valid factory' do
    it { expect(build(:order)).to be_instance_of(Order) }
    it { expect(build(:order, :ownable_group)).to be_instance_of(Order) }
    it { expect(build(:order, :ownable_user)).to be_instance_of(Order) }
    it { expect(build(:order, :pending)).to be_instance_of(Order) }
    it { expect(build(:order, :cancelled)).to be_instance_of(Order) }
    it { expect(build(:order, :complete)).to be_instance_of(Order) }
    it { expect(build(:order, :with_order_items)).to be_instance_of(Order) }
  end

  describe 'data and associations' do
    it { should have_db_column(:shopping_date) }
    it { should have_db_column(:ownable_id) }
    it { should have_db_column(:ownable_type) }
    # it { should belong_to(:location) }
    it { should belong_to(:ownable) }
    it { should have_many(:items) }
    it { should have_many(:order_items) }
    it { should have_many(:assemblies) }
    it { should have_many(:departments) }

  end

  before do
    @order = build(:order)
  end

  subject { @order }

  describe 'validations' do
    it { should be_valid }
    it { should validate_presence_of(:shopping_date) }
  end

  # TODO: re-implement via: https://github.com/n8rzz/shopper/issues/314
  # describe '.duplicate' do
  #   context 'when no pending order exists' do
  #     let(:user) { create(:user) }
  #     let(:complete_order) { create(:order, :complete, ownable: user) }

  #     subject { complete_order.duplicate }

  #     it { expect(subject).to be_instance_of Order }
  #     it { expect(subject.location_id).to eq complete_order.location_id }
  #     # TODO: this should be updated to use at least one actual order_item
  #     it { expect(subject.order_items.size).to eq complete_order.order_items.size }
  #   end

  #   context 'when a pending order exists' do
  #     let(:user) { create(:user) }
  #     let!(:pending_order) { create(:order, :pending, ownable: user) }
  #     let!(:complete_order) { create(:order, :complete, ownable: user) }

  #     it { expect(complete_order.duplicate).to eq nil }
  #   end
  # end

  describe '.live?' do
    let(:user) { create(:user) }
    let!(:pending_order) { create(:order, :pending, ownable: user) }
    let!(:active_order) { create(:order, ownable: user) }
    let!(:complete_order) { create(:order, :complete, ownable: user) }

    it { expect(pending_order.live?).to eq true }
    it { expect(active_order.live?).to eq true }
    it { expect(complete_order.live?).to eq false }
  end

  describe '.delete_assembly' do
    let(:user) { create(:user) }
    let!(:active_order) { create(:order, :with_order_items, ownable: user) }
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
