require 'rails_helper'

RSpec.describe Devise::Mailer do
  it 'sends a confirmation email to the correct email with correct text' do
    user = create(:user, :without_confirmed_at)
    confirmation_email = Devise.mailer.deliveries.last

    expect(user.email).to eq confirmation_email.to[0]
    expect(confirmation_email.body.to_s).to have_content("Welcome #{user.email}")
  end
end
