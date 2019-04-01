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
end
