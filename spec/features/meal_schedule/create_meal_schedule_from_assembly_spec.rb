require 'rails_helper'

RSpec.feature 'create MealSchedule', js: true do
  context 'as a non-grouped user' do
    let(:user) { create(:user) }
    let(:department) { create(:department, ownable: user) }
    let(:item1) { create(:item, department: department, ownable: user) }
    let(:item2) { create(:item, department: department, ownable: user) }
    let!(:assembly) { create(:assembly, item_ids: [item1.id, item2.id], ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    describe 'from assembly#index' do
      before :each do
        visit assemblies_path

        within first('.listItem') do
          click_link('Schedule')
        end

        select 'morning', from: 'Meal time'
        fill_in 'meal_schedule_schedule_date', with: Time.now

        click_button('Create Meal schedule')
      end

      it { expect(page).to have_current_path(meal_schedules_path) }
      it { expect(page).to have_text(assembly.name) }
    end
  end

  context 'as a group user' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: [user.id]) }
    let(:department) { create(:department, ownable: group) }
    let(:item1) { create(:item, department: department, ownable: group) }
    let(:item2) { create(:item, department: department, ownable: group) }
    let!(:assembly) { create(:assembly, item_ids: [item1.id, item2.id], ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    describe 'from assembly#index' do
      before :each do
        visit assemblies_path

        within first('.listItem') do
          click_link('Schedule')
        end

        select 'morning', from: 'Meal time'
        fill_in 'meal_schedule_schedule_date', with: Time.now

        click_button('Create Meal schedule')
      end

      it { expect(page).to have_current_path(meal_schedules_path) }
      it { expect(page).to have_text(assembly.name) }
    end
  end
end
