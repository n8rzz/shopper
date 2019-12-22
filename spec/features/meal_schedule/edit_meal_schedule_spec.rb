require 'rails_helper'

RSpec.feature 'edit a MealSchedule', js: true do
  let(:user) { create(:user) }
  let(:assembly) { create(:assembly, ownable: user) }
  let!(:meal_schedule) { create(:meal_schedule, assembly_id: assembly.id, schedule_date: Time.now, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  describe 'assembly' do
    before :each do
      visit meal_schedules_path

      click_link(meal_schedule.assembly.name)

      select 'morning', from: 'Meal time'
      fill_in 'meal_schedule_schedule_date', with: Time.now

      click_button('Update Meal schedule')
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_selector('.js-notice', text: 'MealSchedule was updated successfully') }
    it { expect(page).to have_text(meal_schedule.assembly.name) }
  end
end
