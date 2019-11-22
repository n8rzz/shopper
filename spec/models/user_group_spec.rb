require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  it 'has a valid factory' do
    expect(build(:user_group)).to be_instance_of(UserGroup)
  end

  describe 'data and associations' do
    it { should have_db_column(:group_id) }
    it { should have_db_column(:user_id) }
    it { should belong_to(:group) }
    it { should belong_to(:user) }
  end

  before do
    @group = build(:user_group)
  end

  subject { @group }

  describe 'validations' do
    it { should be_valid }
    it { should respond_to(:group_id) }
    it { should respond_to(:user_id) }
    # it { should validate_presence_of(:group_id) }
    # it { should validate_presence_of(:user_id) }
  end
end
