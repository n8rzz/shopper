require 'rails_helper'

RSpec.feature 'Group#index', js: true do
  context 'when a user is not a memeber of a group' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    before :each do
      visit groups_path
    end

    it { expect(page).to have_current_path(groups_path) }
    it { expect(page).to have_selector('.island-hd', text: 'Groups') }
    it { expect(page).to have_link('New Group') }
  end

  context 'when a user is a memeber of a group' do
    let(:group) { create(:group) }
    let(:user_with_group) { create(:user, group_ids: group.id) }

    before do
      sign_in user_with_group
    end

    after do
      sign_out user_with_group
    end

    before :each do
      visit groups_path
    end

    it { expect(page).to have_current_path(groups_path) }
    it { expect(page).to_not have_link('New Group') }
    it { expect(page).to have_link(group.name, href: group_path(group.id)) }
    it { expect(page).to have_button('Destroy') }
  end
end
