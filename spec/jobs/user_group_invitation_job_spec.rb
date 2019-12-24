require 'rails_helper'

RSpec.describe UserGroupInvitationJob, type: :job do
  include ActiveJob::TestHelper
  subject (:job) { described_class.perform_later(invited_user) }

  let(:invited_user) { create(:user, email: Faker::Internet.safe_email, invitation_group_id: 13) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(invited_user)
      .on_queue('urgent')
  end

  describe 'does the correct work' do
    before :each do
      perform_enqueued_jobs { job }
      invited_user.reload
    end

    it { expect(invited_user.invitation_group_id).to eq(nil)}
    # it { expect(UserGroup.find_by!(group_id: 13, user_id: invited_user.id)).to_not eq(nil)}
  end
end

