require 'rails_helper'

RSpec.feature 'Session#new', js: true do
  let(:user) { create(:user) }

  context 'when logged in' do
    describe 'and a user visits a protected route' do
      before :each do
        sign_in user

        visit orders_path
      end

      it { expect(page).to have_current_path('/orders') }
      it { expect(page).to have_text('Orders') }
    end
  end

  context 'when not logged in' do
    describe 'and a user visits a protected route' do
      before :each do
        visit orders_path
      end

      it { expect(page).to have_current_path('/users/sign_in') }
      # TODO: update to use error css class
      it { expect(page).to have_selector('.js-notice', text: 'You need to sign in or sign up before continuing') }
      it { expect(page).to_not have_text('Orders') }
    end

    describe 'and a user visits new_user_session_path' do
      before :each do
        visit new_user_session_path
      end

      it { expect(page).to have_current_path('/users/sign_in') }
      it { expect(page).to_not have_selector('.js-notice', text: 'You need to sign in or sign up before continuing') }
    end

    describe 'and user fills in valid login information' do
      before :each do
        visit new_user_session_path

        fill_in 'user_email', with: user.email
        fill_in 'password', with: user.password

        click_button 'Login'
      end

      it { expect(page).to have_current_path('/') }
      it { expect(page).to have_selector('.js-notice', text: 'Signed in successfully.') }
    end

    describe 'and user fills in invalid email' do
      before :each do
        visit new_user_session_path

        fill_in 'user_email', with: 'threeve'
        fill_in 'password', with: user.password

        click_button 'Login'
      end

      it { expect(page).to have_current_path('/users/sign_in') }
      it { expect(page).to have_selector('.js-notice', text: 'Invalid Email or password.') }
    end

    describe 'and user fills in invalid password' do
      before :each do
        visit new_user_session_path

        fill_in 'user_email', with: user.email
        fill_in 'password', with: 'threeve'

        click_button 'Login'
      end

      it { expect(page).to have_current_path('/users/sign_in') }
      it { expect(page).to have_selector('.js-notice', text: 'Invalid Email or password.') }
    end
  end
end
