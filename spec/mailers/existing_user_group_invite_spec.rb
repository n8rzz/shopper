require 'rails_helper'

RSpec.describe ExistingUserGroupInviteMailer, type: :mailer do
  include ActiveJob::TestHelper

  context '.group_invite' do
    let(:current_inviter) { create(:user) }
    let!(:existing_user) { create(:user, invitation_group_token: 'threeve') }
    let!(:mail) { described_class.group_invite(existing_user, current_inviter).deliver_now }

    before do
      perform_enqueued_jobs
    end

    it { expect(mail.to).to eq([existing_user.email]) }
    it { expect(mail.from).to eq(['xrayshoppper@gmail.com']) }
    it { expect(mail.subject).to eq("You've been invited to a Group!") }
    it { expect(mail.body.encoded).to include(groups_invitation_url) }
    it { expect(mail.body.encoded).to include("?invitation_group_token=#{existing_user.invitation_group_token}") }
  end
end
