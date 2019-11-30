require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'has a valid factories' do
    it { expect(build(:group)).to be_instance_of(Group) }
  end

  describe 'data and associations' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
    it { should_not have_db_column(:user_id) }
    it { should have_many(:users).through(:user_groups) }
    it { should have_many(:user_groups).dependent(:destroy) }
    it { should have_many(:locations).dependent(:destroy) }
    it { should have_many(:departments).dependent(:destroy) }
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:assemblies).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  before do
    @group = build(:group)
  end

  subject { @group }

  describe 'validations' do
    it { should be_valid }
    it { should respond_to(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
