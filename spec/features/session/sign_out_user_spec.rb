require 'rails_helper'

RSpec.feature 'Session#destroy', js: true do
  let(:user) { create(:user) }

  context 'when logged in' do
    before :each do
      sign_in user

      visit orders_path

      click_link('Logout')
    end

    it { expect(page).to have_current_path('/users/sign_in') }
  end

  context 'after logging out' do
    before :each do
      sign_in user

      visit orders_path

      click_link('Logout')

      visit orders_path
    end

    it { expect(page).to have_current_path('/users/sign_in') }
    it { expect(page).to have_selector('.js-notice', text: 'You need to sign in or sign up before continuing') }
  end
end
