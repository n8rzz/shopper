require 'rails_helper'

RSpec.feature 'Destroy Department', js: true do
  context 'when current_owner is a user' do
    let(:user) { create(:user) }
    let!(:department) { create(:department, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from department#index' do
      visit departments_path

      within first('.listItem') do
        accept_alert do
          click_button('Destroy')
        end
      end

      expect(page).to have_text('Department was successfully destroyed')
      expect(page).to_not have_text(department.name)
    end
  end

  context 'when current_owner is a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let!(:department) { create(:department, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from department#index' do
      visit departments_path

      within first('.listItem') do
        accept_alert do
          click_button('Destroy')
        end
      end

      expect(page).to have_text('Department was successfully destroyed')
      expect(page).to_not have_text(department.name)
    end
  end
end
