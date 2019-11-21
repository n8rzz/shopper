require 'rails_helper'

RSpec.feature 'confirmable user registration', js: true do
  let(:user) { create(:user, :without_confirmed_at) }

  context 'when visiting the confirmation url' do
    before :each do
      visit "/users/confirmation?confirmation_token=#{user.confirmation_token}"
    end

    it { expect(page).to have_selector('.js-notice', text: 'Your email address has been successfully confirmed.') }
    it { expect(page).to have_selector('.island-hd', text: 'Log in') }
  end
end

