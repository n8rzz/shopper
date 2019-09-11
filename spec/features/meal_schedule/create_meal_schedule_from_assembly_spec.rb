require 'rails_helper'

RSpec.feature 'create MealSchedule', js: true do
  let!(:assembly) { create(:assembly, :with_item) }

  describe 'from assembly#index' do
    before :each do
      visit assemblies_path

      within '.listItem' do
        click_link('Schedule')
      end

      select 'morning', from: 'Meal time'
      fill_in 'meal_schedule_schedule_date', with: Time.now

      click_button 'Create Meal schedule'
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_text(assembly.name) }
  end
end
