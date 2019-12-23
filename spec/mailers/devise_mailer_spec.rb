require 'rails_helper'

RSpec.describe Devise::Mailer do
  include ActiveJob::TestHelper

  let!(:user) { create(:user, :without_confirmed_at) }

  it 'sends a confirmation email to the correct email with correct text' do
    perform_enqueued_jobs

    confirmation_email = Devise.mailer.deliveries.last

    expect(user.email).to eq confirmation_email.to[0]
    expect(confirmation_email.body.to_s).to have_content("Welcome #{user.email}")
  end
end
