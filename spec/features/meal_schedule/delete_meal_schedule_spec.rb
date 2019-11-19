require 'rails_helper'

RSpec.feature 'Delete a MealSchedule', js: true do
  let!(:meal_schedule) { create(:meal_schedule, :with_item, schedule_date: Time.now) }
  let(:user) { create(:user) }

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
