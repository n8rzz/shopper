require 'rails_helper'

RSpec.describe User, type: :model do
  include ActiveJob::TestHelper

  context 'has a valid factories' do
    it { expect(build(:user)).to be_instance_of(User) }
    it { expect(build(:user, :without_confirmed_at)).to be_valid }
    it { expect(build(:user, email: nil)).to_not be_valid }
  end

  describe 'data and associations' do
    it { should have_db_column(:username) }
    it { should have_db_column(:email) }
    it { should have_db_column(:encrypted_password) }
    it { should have_db_column(:reset_password_token) }
    it { should have_db_column(:reset_password_sent_at) }
    it { should have_db_column(:remember_created_at) }
    it { should have_db_column(:sign_in_count).with_options(default: 0) }
    it { should have_db_column(:current_sign_in_at) }
    it { should have_db_column(:last_sign_in_at) }
    it { should have_db_column(:current_sign_in_ip) }
    it { should have_db_column(:last_sign_in_ip) }
    it { should have_db_column(:invitation_group_id) }
    it { should have_db_index(:email) }
    it { should have_db_index(:reset_password_token) }
    it { should have_many(:groups).through(:user_groups) }
    it { should have_many(:user_groups).dependent(:destroy) }
    it { should have_many(:locations).dependent(:destroy) }
    it { should have_many(:departments).dependent(:destroy) }
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:assemblies).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:meal_schedules).dependent(:destroy) }
  end

  before do
    @user = build(:user)
  end

  subject { @user }

  describe 'validations' do
    # it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'after creation' do
    let(:confirmable_user) { build(:user, :without_confirmed_at) }

    it 'sends a confirmation email' do
      expect { confirmable_user.save }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end
  end

  describe '.has_groups?' do
    let!(:ungrouped_user) { create(:user) }
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let!(:user_group) { create(:user_group, user_id: user.id, group_id: group.id) }

    it { expect(ungrouped_user.has_groups?).to be(false) }
    it { expect(user.has_groups?).to be(true) }
  end

  describe '.remove_invitation_group_id_after_invitaion_acceptence' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let(:invited_unconfirmed_user) { create(:user, invitation_group_id: group.id) }

    before :each do
      User.remove_invitation_group_id_after_invitaion_acceptence(invited_unconfirmed_user)
    end

    it { expect(invited_unconfirmed_user.invitation_group_id).to be_nil }
  end
end
