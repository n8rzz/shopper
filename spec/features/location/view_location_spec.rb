require 'rails_helper'

RSpec.feature 'View a Location', js: true do
  let(:user_without_location) { create(:user) }
  let(:user) { create(:user) }
  let(:user_with_group) { create(:user) }
  let!(:group) { create(:group, user_ids: user_with_group.id) }

  context 'when a location is owned by current_owner' do
    context 'and is owned by current_user' do
      let!(:user_owned_location) { create(:location, ownable: user) }

      before do
        sign_in user

        visit locations_path
      end

      after do
        sign_out user
      end

      it { expect(page).to have_content(user_owned_location.name) }
    end

    context 'and is owned by current_group' do
      let!(:group_owned_location) { create(:location, ownable: group) }

      before do
        sign_in user_with_group

        visit locations_path
      end

      after do
        sign_out user_with_group
      end

      it { expect(page).to have_content(group_owned_location.name) }
    end
  end

  context 'when a location is not owned by current_owner' do
    let!(:location) { create(:location, ownable: user) }

    before :each do
      sign_in user_without_location

      visit locations_path
    end

    after :each do
      sign_out user_without_location
    end

    it { expect(page).to_not have_content(location.name) }
  end
end
