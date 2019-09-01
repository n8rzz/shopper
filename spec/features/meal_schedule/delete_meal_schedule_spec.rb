require 'rails_helper'

RSpec.feature 'Delete a MealSchedule', js: true do
  # FIXME: schedule doesn't appear in view, so selection fails
  # let!(:meal_schedule) { create(:meal_schedule, :with_item) }

  # scenario 'from meal_schedule#index' do
  #   visit meal_schedules_path

  #   puts meal_schedule.to_json

  #   save_and_open_page

  #   within first('.mealSchedule-bd-itemList-item') do
  #     find('.js-mealSchedule-remove').click
  #   end

  #   expect(page).to_not have_text(meal_schedule.item.name)
  # end
end
