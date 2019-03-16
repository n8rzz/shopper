require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'has a valid factory' do
    expect(build(:item)).to be_instance_of(Item)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should belong_to(:department) }
    it { should have_many(:order_items) }
    it { should have_many(:assembly_items) }
    it { should have_many(:assemblies) }
  end

  before do
    @item = build(:item)
  end

  subject { @item }

  describe 'validations' do
    it { should respond_to(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should be_valid }
  end
end
