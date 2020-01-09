require 'rails_helper'

RSpec.feature 'invite an existing user to group', js: true do
  include ActiveJob::TestHelper

  let(:existing_user) { create(:user, password: Faker::Internet.password, invitation_group_token: 'threeve') }
  let!(:user) { create(:user, email: Faker::Internet.safe_email) }
  let(:group) { create(:group, user_ids: user.id) }

  before :each do
    sign_in user
    visit group_path(group.id)
  end

  after do
    sign_out user
  end

  context 'completing invite form sends invite to user' do
    before :each do
      fill_in 'user_email', with: existing_user.email

      click_button('Invite')
    end

    it { expect(page).to have_current_path(group_path(group.id)) }
    it { expect(page).to have_selector('.js-notice', text: "Good news, #{existing_user.email} is already a user!") }
    it { expect(page).to have_content(existing_user.email) }
  end

  context 'invited user must login after accepting invitation' do
    before :each do
      fill_in 'user_email', with: existing_user.email

      click_button('Invite')
      click_link('Logout')

      perform_enqueued_jobs

      open_email(existing_user.email)
      visit_in_email('Group Invitation')

      fill_in 'user_email', with: existing_user.email
      fill_in 'user_password', with: existing_user.password

      click_button('Login')
    end

    it { expect(page).to have_current_path(group_invitation_path(group.id), ignore_query: true) }
  end
end
