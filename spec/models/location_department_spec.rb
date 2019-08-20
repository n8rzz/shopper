require 'rails_helper'

RSpec.describe LocationDepartment, type: :model do
  it 'has a valid factory' do
    expect(build(:location_department)).to be_instance_of(LocationDepartment)
  end

  describe 'data and associations' do
    it { should have_db_column(:sort_order) }
    it { should belong_to(:location) }
    it { should belong_to(:department) }
  end

  subject { build(:location_department) }

  describe 'validations' do
    it { should be_valid }
    it { should validate_numericality_of(:sort_order).is_greater_than_or_equal_to(0) }
  end

  # describe 'self.find_all_by_location_id' do
  # end

  # describe 'self.find_displaced_record_by_direction' do
  # end
end
