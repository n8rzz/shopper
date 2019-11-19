require 'rails_helper'

RSpec.feature 'create MealSchedule', js: true do
  let!(:assembly) { create(:assembly, :with_item) }
  let(:user) { create(:user) }

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

      click_button 'Create Meal schedule'
    end

    it { expect(page).to have_current_path(meal_schedules_path) }
    it { expect(page).to have_text(assembly.name) }
  end
end
