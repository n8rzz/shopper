require 'rails_helper'

RSpec.feature 'registrations#edit', js: true do
  let(:existing_user) { create(:user, email: 'tom@example.com', password: '$texas' ) }
  let(:user) { build(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'view template' do
    before :each do
      visit edit_user_registration_path
    end

    it { expect(page).to have_link('Orders') }
    it { expect(page).to have_link('Assemblies') }
    it { expect(page).to have_link('Items') }
    it { expect(page).to have_link('Logout') }
    it { expect(page).to have_button('Update') }
  end

  context 'with valid information' do
    before :each do
      visit edit_user_registration_path

      fill_in 'user_email', with: 'me@example.com'
      fill_in 'user_current_password', with: user.password

      click_button('Update')
    end

    it { expect(page).to_not have_selector('.error_notification', text: 'Please review the problems below:') }
  end

  # context 'with invalid information' do
  #   before :each do
  #     visit edit_user_registration_path
  #   end

  #   describe 'an email that already exists' do
  #     before :each do
  #       fill_in 'user_email', with: existing_user.email
  #       fill_in 'user_current_password', with: user.password

  #       click_button('Update')

  #       save_and_open_page
  #     end

  #     it { expect(page).to_not have_current_path('/') }
  #     it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
  #     it { expect(page).to have_selector('.error', text: 'has already been taken') }
  #   end
  # end
end

