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
  end

  describe '.add_user_to_invited_group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let(:invited_unconfirmed_user) { create(:user, invitation_group_id: group.id) }

    before :each do
      UserGroup.add_user_to_invited_group(invited_unconfirmed_user)
    end

    it { expect(UserGroup.where(group_id: group.id, user_id: invited_unconfirmed_user.id)).to_not be_nil }
  end
end
