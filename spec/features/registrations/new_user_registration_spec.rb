require 'rails_helper'

RSpec.feature 'registrations#new', js: true do
  let(:existing_user) { create(:user, email: 'tom@example.com', password: '$texas' ) }
  let(:user) { build(:user) }

  context 'view template' do
    before :each do
      visit new_user_registration_path
    end

    it { expect(page).to have_link('Log in') }
  end

  context 'with valid information' do
    before :each do
      visit new_user_registration_path

      fill_in 'user_username', with: user.username
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password

      click_button('Sign up')
    end

    it { expect(page).to have_current_path('/static_pages/after_signup') }
    it { expect(page).to have_selector('.js-notice', text: 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.') }
    it { expect(page).to have_text('Just one more step!') }
  end

  context 'with invalid information' do
    before :each do
      visit new_user_registration_path
    end

    # TODO: disabled to support user invites, need to re-implement
    # describe 'a username that already exists' do
    #   before :each do
    #     fill_in 'user_username', with: existing_user.username
    #     fill_in 'user_email', with: user.email
    #     fill_in 'user_password', with: user.password
    #     fill_in 'user_password_confirmation', with: user.password

    #     click_button('Sign up')
    #   end

    #   it { expect(page).to_not have_current_path('/') }
    #   it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
    #   it { expect(page).to have_selector('.error', text: 'has already been taken') }
    # end

    describe 'an email that already exists' do
      before :each do
        fill_in 'user_email', with: existing_user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password

        click_button('Sign up')
      end

      it { expect(page).to_not have_current_path('/') }
      it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
      it { expect(page).to have_selector('.error', text: 'has already been taken') }
    end

    describe 'a password thats too short' do
      before :each do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: '123'
        fill_in 'user_password_confirmation', with: '123'

        click_button('Sign up')
      end

      it { expect(page).to_not have_current_path('/') }
      it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
      it { expect(page).to have_selector('.error', text: 'is too short (minimum is 6 characters)') }
    end

    describe 'a password_confirmation that doesnt match' do
      before :each do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: '123'

        click_button('Sign up')
      end

      it { expect(page).to_not have_current_path('/') }
      it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
      it { expect(page).to have_selector('.error', text: 'doesn\'t match Password') }
    end
  end
end

