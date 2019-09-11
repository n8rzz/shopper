require 'rails_helper'

RSpec.feature 'Delete a MealSchedule', js: true do
  let!(:meal_schedule) { create(:meal_schedule, :with_item, schedule_date: Time.now) }

  scenario 'from meal_schedule#index' do
    visit meal_schedules_path

    within first('.mealSchedule-bd-itemList-item') do
      find('.js-mealSchedule-remove').click
    end

    expect(page).to_not have_text(meal_schedule.item.name)
  end
end
