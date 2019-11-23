require 'rails_helper'

RSpec.feature 'Group#new', js: true do
  context 'when a user is not a memeber of a group' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'visit group#new from #index' do
      before :each do
        visit groups_path

        click_link('New Group')
      end

      it { expect(page).to have_current_path(new_group_path) }
    end

    context 'create with name that already exists' do
      let(:existing_group) { create(:group, user_ids: user.id) }

      before :each do
        visit new_group_path

        fill_in 'name', with: existing_group.name
        fill_in 'description', with: Faker::Company.bs

        click_button('Create Group')
      end

      # FIXME: maintaining groups_path on failure for some reason
      # it { expect(page).to have_current_path(new_group_path) }
      it { expect(page).to have_selector('.error_notification', text: 'Please review the problems below:') }
      it { expect(page).to have_selector('.error', text: 'has already been taken') }
    end

    context 'create a new group' do
      before :each do
        visit new_group_path

        fill_in 'name', with: '$texas'
        fill_in 'description', with: Faker::Company.bs

        click_button('Create Group')
      end

      it { expect(page).to have_current_path(groups_path) }
      it { expect(page).to have_selector('.js-notice', text: 'Group was successfully created.') }
      it { expect(page).to have_content('$texas') }
    end
  end
end
