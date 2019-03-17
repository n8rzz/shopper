require 'rails_helper'

RSpec.describe Assembly, type: :model do
  it 'has a valid factory' do
    expect(build(:assembly)).to be_instance_of(Assembly)
    expect(build(:assembly, :with_item)).to be_instance_of(Assembly)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_many(:order_items) }
    it { should have_many(:orders) }
    it { should have_many(:assembly_items) }
    it { should have_many(:assemblies) }
    it { should have_many(:items) }
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
end
