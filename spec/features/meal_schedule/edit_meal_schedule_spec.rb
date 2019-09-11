require 'rails_helper'

RSpec.feature 'edit a MealSchedule', js: true do
  let!(:meal_schedule) { create(:meal_schedule, :with_assembly, schedule_date: Time.now) }

  describe 'assembly' do
    before :each do
      visit meal_schedules_path

      click_link meal_schedule.assembly.name

      select 'morning', from: 'Meal time'
      fill_in 'meal_schedule_schedule_date', with: Time.now

      click_button 'Update Meal schedule'
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_text('MealSchedule was updated successfully') }
    it { expect(page).to have_text(meal_schedule.assembly.name) }
  end
end
