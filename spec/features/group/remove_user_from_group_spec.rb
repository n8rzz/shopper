require 'rails_helper'

RSpec.feature 'remove user from group', js: true do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:group) { create(:group, user_ids: [user.id, user2.id]) }

  before do
    sign_in user
    visit group_path(group.id)
  end

  after do
    sign_out user
  end

  context 'does not display remove member button for current_user' do
    it { expect(page).to have_link('Remove', count: 1) }
  end

  context 'clicking remove reduces group member count by 1' do
    before :each do
      accept_confirm do
        click_link('Remove')
      end
    end

    it { expect(page).to_not have_selector('.js-notice', text: "#{user2.username} was removed successfully") }
    it { expect(page).to have_selector('.listItem', count: 1) }
    it { expect(page).to_not have_selector('.listItem-hd', text: user2.username) }
  end
end
