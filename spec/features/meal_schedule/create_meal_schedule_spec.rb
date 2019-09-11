require 'rails_helper'

RSpec.feature 'Create a MealSchedule', js: true do
  let!(:item) { create(:item) }
  let!(:assembly) { create(:assembly) }

  describe 'with assembly' do
    before :each do
      visit meal_schedules_path

      click_link('New Schedule')

      select 'morning', from: 'Meal time'
      select assembly.name, from: 'Assembly'
      fill_in 'meal_schedule_schedule_date', with: Time.now

      click_button 'Create Meal schedule'
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_text('MealSchedule was added successfully') }
    it { expect(page).to have_text(assembly.name) }
    it { expect(find(".qa-calendarTable-td-cell-#{Date.parse(Time.now.to_s).day}")) }
  end

  describe 'with item' do
    before :each do
      visit meal_schedules_path

      click_link('New Schedule')

      select 'morning', from: 'Meal time'
      select item.name, from: 'Item'
      fill_in 'meal_schedule_schedule_date', with: Time.now

      click_button 'Create Meal schedule'
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_text('MealSchedule was added successfully') }
    it { expect(page).to have_text(item.name) }
    it { expect(find(".qa-calendarTable-td-cell-#{Date.parse(Time.now.to_s).day}")) }
  end
end
