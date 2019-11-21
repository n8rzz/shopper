require 'rails_helper'

RSpec.feature 'previously confirmed user registration', js: true do
  let(:user) { create(:user, :without_confirmed_at) }

  before do
    visit "/users/confirmation?confirmation_token=#{user.confirmation_token}"
  end

  context 'when visiting the confirmation url' do
    before :each do
      visit "/users/confirmation?confirmation_token=#{user.confirmation_token}"
    end

    it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
    it { expect(page).to have_selector('.error', text: 'was already confirmed, please try signing in') }
  end
end
