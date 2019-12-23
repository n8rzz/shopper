require 'rails_helper'

RSpec.feature 'view a MealSchedule', js: true do
  context 'as a non-group user' do
    let(:user) { create(:user) }
    let(:assembly) { create(:assembly, ownable: user) }
    let!(:meal_schedule) { create(:meal_schedule, assembly_id: assembly.id, schedule_date: Time.now, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    before :each do
      visit meal_schedules_path
    end

    it { expect(page).to have_selector('.calendarTable') }
  end

  context 'as a group user' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: [user.id]) }
    let(:assembly) { create(:assembly, ownable: group) }
    let!(:meal_schedule) { create(:meal_schedule, assembly_id: assembly.id, schedule_date: Time.now, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    before :each do
      visit meal_schedules_path
    end

    it { expect(page).to have_selector('.calendarTable') }
  end
end
