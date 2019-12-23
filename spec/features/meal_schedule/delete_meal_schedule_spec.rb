require 'rails_helper'

RSpec.feature 'Delete a MealSchedule', js: true do
  context 'as a non-grouped user' do
    let(:user) { create(:user) }
    let(:item) { create(:item, ownable: user) }
    let!(:meal_schedule) { create(:meal_schedule, item_id: item.id, schedule_date: Time.now, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from meal_schedule#index' do
      visit meal_schedules_path

      within first('.mealSchedule-bd-itemList-item') do
        find('.js-mealSchedule-remove').click
      end

      expect(page).to_not have_text(meal_schedule.item.name)
    end
  end

  context 'as a group user' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: [user.id]) }
    let(:item) { create(:item, ownable: group) }
    let!(:meal_schedule) { create(:meal_schedule, item_id: item.id, schedule_date: Time.now, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from meal_schedule#index' do
      visit meal_schedules_path

      within first('.mealSchedule-bd-itemList-item') do
        find('.js-mealSchedule-remove').click
      end

      expect(page).to_not have_text(meal_schedule.item.name)
    end
  end
end
