require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'has a valid factory' do
    expect(build(:location)).to be_instance_of(Location)
    expect(build(:location, :ownable_group)).to be_instance_of(Location)
    expect(build(:location, :ownable_user)).to be_instance_of(Location)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_db_column(:city) }
    it { should have_db_column(:state) }
    it { should have_db_column(:ownable_id) }
    it { should have_db_column(:ownable_type) }
    it { should belong_to(:ownable) }
    it { should have_many(:location_departments) }
    it { should have_many(:departments) }
  end

  before do
    @location = build(:location, :ownable_user)
  end

  subject { @location }

  describe 'validations' do
    it { should respond_to(:name) }
    it { should respond_to(:city) }
    it { should respond_to(:state) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should be_valid }
  end

  describe 'when #city and #state are defined' do
    it 'returns the correct string' do
      valid_location = build_stubbed(:location)

      expect(valid_location.city_and_state).to eq("#{valid_location.city}, #{valid_location.state}")
    end
  end

  describe 'by_name sorts in ASC' do
    let!(:cub) { create(:location, name: 'cub') }
    let!(:target) { create(:location, name: 'target') }

    it 'returns records in correct order' do
      expect(Location.by_name).to eq [cub, target]
    end
  end
end
