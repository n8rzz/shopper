require 'rails_helper'

RSpec.feature 'Group#edit', js: true do
  context 'when editing a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'visiting /groups/:id/edit' do
      before :each do
        visit edit_group_path(group.id)
      end

      it { expect(page).to have_current_path(edit_group_path(group.id)) }
      it { expect(page).to have_selector('.hdg', text: 'Edit Group') }
      it { expect(page).to have_link('Back') }
    end

    before :each do
      visit edit_group_path(group.id)

      fill_in 'name', with: 'Threeve'

      click_button('Update Group')
    end

    it { expect(page).to have_current_path(groups_path) }
    it { expect(page).to have_selector('.js-notice', text: 'Group was successfully updated.') }
    it { expect(page).to have_content('Threeve') }
  end
end
