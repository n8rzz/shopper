require 'rails_helper'

RSpec.feature 'invite user to group', js: true do
  include ActiveJob::TestHelper

  let!(:user) { create(:user, email: Faker::Internet.safe_email) }
  let(:group) { create(:group, user_ids: user.id) }
  invitation_email = 'dvader@empire.com'

  before :each do
    sign_in user
    visit group_path(group.id)
  end

  after :each do
    sign_out user
  end

  context 'completing invite form sends invite to user' do
    before :each do
      fill_in 'user_email', with: invitation_email

      click_button('Invite')
    end

    it { expect(page).to have_current_path(group_path(group.id)) }
    it { expect(page).to have_selector('.js-notice', text: "An invitation email has been sent to #{invitation_email}") }
    it { expect(page).to have_content(invitation_email) }
  end

  context 'invited user can accept invitation' do
    before :each do
      fill_in 'user_email', with: invitation_email
      click_button('Invite')
      click_link('Logout')

      perform_enqueued_jobs

      open_email(invitation_email)
      visit_in_email('Accept invitation')

      fill_in 'user_username', with: 'DarthVader'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'

      click_button('Create Account')
    end

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_selector('.js-notice', text: 'Your account was created successfully') }
  end

  context 'invited user is added to correct group' do
    let (:invited_user) { User.find_by(username: 'DarthVader') }

    before :each do
      fill_in 'user_email', with: invitation_email
      click_button('Invite')
      click_link('Logout')

      perform_enqueued_jobs

      open_email(invitation_email)
      visit_in_email('Accept invitation')

      fill_in 'user_username', with: 'DarthVader'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'

      click_button('Create Account')

      perform_enqueued_jobs
    end

    it { expect(invited_user).to_not eq(nil) }
    it { expect(invited_user.groups.exists?(id: group.id)).to eq(true) }
  end

  context 'invited user must login after accepting invitation' do
    before :each do
      fill_in 'user_email', with: invitation_email
      click_button('Invite')
      click_link('Logout')

      perform_enqueued_jobs

      open_email(invitation_email)
      visit_in_email('Accept invitation')

      fill_in 'user_username', with: 'DarthVader'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'

      click_button('Create Account')

      fill_in 'user_email', with: invitation_email
      fill_in 'user_password', with: '123456'

      click_button('Login')
    end

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_selector('.js-notice', text: 'Signed in successfully') }
  end
end
