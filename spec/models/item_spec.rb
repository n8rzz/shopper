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
    it { should have_many(:assemblies) }
    it { should have_many(:meal_schedules) }
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

  describe 'by_name returns Items in ASC order' do
    let(:orange) { create(:item, name: 'Orange') }
    let(:apple) { create(:item, name: 'Apple') }

    it 'returns Items sorted ASC' do
      expect(Item.by_name).to eq([apple, orange])
    end
  end

  describe 'by_id' do
    describe 'returns a hash of Items by #id' do
      let!(:item_1) { create(:item) }
      let!(:item_2) { create(:item) }

      before :each do
        @item_hash = Item.by_id
      end

      it { expect(@item_hash[item_1['id']]).to eq(item_1) }
      it { expect(@item_hash[item_2['id']]).to eq(item_2) }
    end
  end


  # FIXME: fill this test in
  # describe '.group_by_department' do
  #   let(:orange) { create(:item, name: 'Orange') }
  #   let(:apple) { create(:item, name: 'Apple') }

  #   it { expect(Item.group_by_department).to_not eq nil }
  # end
end
