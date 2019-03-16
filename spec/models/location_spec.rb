require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'has a valid factory' do
    expect(build(:location)).to be_instance_of(Location)
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_db_column(:city) }
    it { should have_db_column(:state) }
  end

  before do
    @location = build(:location)
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
end
