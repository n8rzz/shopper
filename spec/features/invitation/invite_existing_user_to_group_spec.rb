require 'rails_helper'

RSpec.feature 'invite user to group', js: true do
  let(:existing_user) { create(:user) }
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
end
