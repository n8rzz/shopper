require 'rails_helper'

RSpec.feature 'Create an Location', js: true do
  let(:user) { create(:user) }

  context 'when user clicks `New Location`' do
    before :each do
      sign_in user

      visit locations_path
      click_link('New Location')
    end

    it { expect(page).to have_no_css('mix-flyout_isHidden') }
    it { expect(page).to have_no_link('Destroy') }
  end

  context 'when a user is not a member of a group' do
    before :each do
      sign_in user

      visit locations_path
      click_link('New Location')

      fill_in 'Name', with: 'Icebox'
      fill_in 'City', with: 'Hell'
      fill_in 'State', with: 'TX'
      click_button('Create Location')
    end

    after :each do
      sign_out user
    end

    context 'and the location form is submitted' do
      it { expect(page).to have_text('Location was created successfully') }
      it { expect(page).to have_current_path(locations_path) }
      it { expect(page).to have_text('Icebox') }
    end
  end

  context 'when a user is a member of a group' do
    let(:user_with_group) { create(:user) }
    let!(:group) { create(:group, user_ids: user_with_group.id) }

    context 'and the location form is submitted' do
      before :each do
        sign_in user_with_group

        visit locations_path
        click_link('New Location')

        fill_in 'Name', with: 'Icebox'
        fill_in 'City', with: 'Hell'
        fill_in 'State', with: 'TX'
        click_button('Create Location')
      end

      after :each do
        sign_out user_with_group
      end

      it { expect(page).to have_text('Location was created successfully') }
      it { expect(page).to have_current_path(locations_path) }
      it { expect(page).to have_text('Icebox') }
    end
  end
end
