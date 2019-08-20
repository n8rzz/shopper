require 'rails_helper'

RSpec.describe Department, type: :model do
  it 'has a valid factory' do
    expect(build(:department)).to be_instance_of(Department)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_many(:items) }
    it { should have_many(:order_items) }
    it { should have_many(:location_departments) }
    it { should have_many(:locations) }
    it { should have_many(:orders) }
  end

  before do
    @department = build(:department)
  end

  subject { @department }

  describe 'validations' do
    it { should respond_to(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should be_valid }
  end

  describe 'by_name sorts in ASC' do
    let(:deli) { create(:department, name: 'deli') }
    let(:produce) { create(:department, name: 'produce') }

    it 'returns records in correct order' do
      expect(Department.by_name).to eq [deli, produce]
    end
  end
end
