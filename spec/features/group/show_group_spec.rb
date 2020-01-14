require 'rails_helper'

RSpec.feature 'Group#show', js: true do
  let!(:user) { create(:user) }
  let!(:group) { create(:group, user_ids: [user.id]) }
  # TODO: this should live in a smaller scope
  let!(:pending_user) { create(:user, invitation_group_id: group.id) }

  before do
    sign_in user
    visit group_path(group.id)
  end

  after do
    sign_out user
  end

  context 'displays group information' do
    it { expect(page).to have_current_path(group_path(group.id)) }
    it { expect(page).to have_link('Back', href: groups_path) }
    it { expect(page).to have_link('Edit', href: edit_group_path(group.id)) }
    it { expect(page).to have_content(group.name) }
    it { expect(page).to have_content(group.description) }
  end

  context 'when there are no pending user invites for a group' do
    it { expect(page).to have_selector('.hdg', text: 'Members') }
    it { expect(page).to have_selector('.listItem-hd', text: user.username) }
    it { expect(page).to have_selector('.listItem-ft', text: user.email) }
  end

  context 'when there are pending invites for a group' do
    it { expect(page).to have_selector('.hdg', text: 'Pending Invites') }
    it { expect(page).to have_selector('.listItem-ft', text: pending_user.email) }
    it { expect(page).to have_selector('.link', text: 'Remove') }
  end
end
