require 'rails_helper'

RSpec.feature 'Create an Item', js: true do
  context 'when user is a member of a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let(:department) { create(:department, name: 'Produce', ownable: group) }
    let!(:item) { create(:item, department: department, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    before :each do
      visit items_path
      click_link('New Item')
    end

    context 'when user clicks `New Item`' do
      it { expect(page).to have_no_css('mix-flyout_isHidden') }
      it { expect(page).to have_no_link('Destroy') }
    end

    context 'when a user completes Item form' do
      before :each do
        fill_in 'Name', with: '$texas'
        select department.name, from: 'Department'

        click_button('Create Item')
      end

      it { expect(page).to have_text('$texas') }
      it { expect(page).to have_text('Item was created successfully') }
      it { expect(page).to have_current_path(items_path) }
      it { expect(page).to have_css('.mix-flyout_isHidden') }
    end
  end

  context 'when user is not a member of a group' do
    let(:user) { create(:user) }
    let(:department) { create(:department, name: 'Produce', ownable: user) }
    let!(:item) { create(:item, department: department, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    before :each do
      visit items_path
      click_link('New Item')
    end

    context 'when user clicks `New Item`' do
      it { expect(page).to have_no_css('mix-flyout_isHidden') }
      it { expect(page).to have_no_link('Destroy') }
    end

    context 'when a user completes Item form' do
      before :each do
        fill_in 'Name', with: '$texas'
        select department.name, from: 'Department'

        click_button('Create Item')
      end

      it { expect(page).to have_text('$texas') }
      it { expect(page).to have_text('Item was created successfully') }
      it { expect(page).to have_current_path(items_path) }
      it { expect(page).to have_css('.mix-flyout_isHidden') }
    end
  end
end
