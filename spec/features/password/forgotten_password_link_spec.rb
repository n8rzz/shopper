require 'rails_helper'

RSpec.feature 'password#new', js: true do
  let(:user) { create(:user) }

  context 'clicking forgot password link from login form' do
    before :each do
      visit new_user_session_path

      click_link('Forgot your password?')
    end

    it { expect(page).to have_current_path('/users/password/new') }
    it { expect(page).to have_link('Sign up') }
    it { expect(page).to have_link('Log in') }
  end

  context 'fill in the forgot password form' do
    before :each do
      visit new_user_password_path
    end

    describe 'with valid information' do
      before :each do
        fill_in 'user_email', with: user.email

        click_button('Send me reset password instructions')
      end

      it { expect(page).to have_selector('.js-notice', text: 'You will receive an email with instructions on how to reset your password in a few minutes.') }
      it { expect(page).to have_current_path('/users/sign_in') }
    end

    describe 'with invalid information' do
      before :each do
        click_button('Send me reset password instructions')
      end

      it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
      it { expect(page).to have_selector('.error', text: 'can\'t be blank') }
    end
  end
end
