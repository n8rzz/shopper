require 'rails_helper'

RSpec.feature 'List Departments', js: true do
  context 'when a user belongs to a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let!(:department) { create(:department, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'has the correct elements' do
      before :each do
        visit departments_path
      end

      it { expect(page).to have_selector('.js-flyout-trigger', text: 'New') }
      it { expect(page).to have_button('Destroy') }
      it { expect(page).to have_selector('.link', text: department.name) }
    end
  end

  context 'when a user does not belong to a group' do
    let(:user) { create(:user) }
    let!(:department) { create(:department, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    context 'has the correct elements' do
      before :each do
        visit departments_path
      end

      it { expect(page).to have_selector('.js-flyout-trigger', text: 'New') }
      it { expect(page).to have_button('Destroy') }
      it { expect(page).to have_selector('.link', text: department.name) }
    end
  end

  context 'when a user does not own the Department' do
    let!(:non_owner_user) { create(:user) }
    let(:user) { create(:user) }
    let!(:department) { create(:department, ownable: user) }

    before do
      sign_in non_owner_user
    end

    after do
      sign_out non_owner_user
    end

    context 'has the correct elements' do
      before :each do
        visit departments_path
      end

      it { expect(page).to have_selector('.js-flyout-trigger', text: 'New') }
      it { expect(page).to_not have_button('Destroy') }
      it { expect(page).to_not have_selector('.link', text: department.name) }
    end
  end
end
