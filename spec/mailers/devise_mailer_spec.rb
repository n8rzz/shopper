require 'rails_helper'

RSpec.describe Devise::Mailer, type: :mailer do
  include ActiveJob::TestHelper

  context 'when a new user is invited' do
    let!(:user) { create(:user, :without_confirmed_at) }

    it 'sends a confirmation email to the correct email with correct text' do
      perform_enqueued_jobs

      confirmation_email = Devise.mailer.deliveries.last

      expect(confirmation_email.to[0]).to eq(user.email)
      expect(confirmation_email.body.to_s).to have_content("Welcome #{user.email}")
    end
  end
end
