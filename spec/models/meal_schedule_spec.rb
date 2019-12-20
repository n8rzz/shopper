require 'rails_helper'

RSpec.describe MealSchedule, type: :model do
  it 'has a valid factory' do
    expect(build(:meal_schedule, :ownable_group)).to be_instance_of(MealSchedule)
    expect(build(:meal_schedule, :ownable_user)).to be_instance_of(MealSchedule)
    expect(build(:meal_schedule, :with_item)).to be_instance_of(MealSchedule)
    expect(build(:meal_schedule, :with_assembly)).to be_instance_of(MealSchedule)
    expect(build(:meal_schedule, :with_order_item)).to be_instance_of(MealSchedule)
  end

  describe 'data and associations' do
    it { should have_db_column(:schedule_date) }
    it { should have_db_column(:purchased) }
    it { should have_db_column(:ownable_id) }
    it { should have_db_column(:ownable_type) }
    it { should belong_to(:ownable) }
    it { should belong_to(:item).optional }
    it { should belong_to(:assembly).optional }
    it { should belong_to(:order_item).optional }
  end

  describe 'validations' do
    before do
      @meal_schedule = build(:meal_schedule, :with_item)
    end

    subject { @meal_schedule }

    it { should respond_to(:schedule_date) }
    it { should respond_to(:purchased) }
    it { should respond_to(:meal_time) }
    it { should validate_presence_of(:schedule_date) }
    it { should be_valid }
  end

  describe 'validate reference_id' do
    before do
      @meal_schedule_item = build(:meal_schedule, :with_item)
      @meal_schedule_assembly = build(:meal_schedule, :with_assembly)
    end

    it { expect(@meal_schedule_item).to be_valid }
    it { expect(@meal_schedule_assembly).to be_valid }
    it { expect(build(:meal_schedule)).to_not be_valid }
    it { expect(build(:meal_schedule, :with_item, :with_assembly)).to_not be_valid }
  end
end
