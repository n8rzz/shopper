require 'rails_helper'

RSpec.describe Assembly, type: :model do
  it 'has a valid factory' do
    expect(create(:assembly)).to be_instance_of(Assembly)
    expect(create(:assembly, :with_item)).to be_instance_of(Assembly)
    expect(create(:assembly, :with_items, items_count: 3)).to be_instance_of(Assembly)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_many(:order_items) }
    it { should have_many(:orders) }
    it { should have_many(:assembly_items) }
    it { should have_many(:assemblies) }
    it { should have_many(:items) }
    it { should have_many(:meal_schedules) }
  end

  before do
    @assembly = build(:assembly)
  end

  subject { @assembly }

  describe 'validations' do
    it { should respond_to(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should be_valid }
  end

  describe 'by_id' do
    describe 'returns a hash of Assemblies by #id' do
      let!(:assembly_1) { create(:assembly) }
      let!(:assembly_2) { create(:assembly) }

      before :each do
        @assembly_hash = Assembly.by_id
      end

      it { expect(@assembly_hash[assembly_1['id']]).to eq(assembly_1) }
      it { expect(@assembly_hash[assembly_2['id']]).to eq(assembly_2) }
    end
  end
end
