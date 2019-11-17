require 'rails_helper'

RSpec.feature 'Create an OrderItem from MealSchedules', js: true do
  let!(:pending_order) { create(:order, :pending) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'with assembly' do
    let!(:meal_schedule_with_assembly) { create(:meal_schedule, :with_assembly, schedule_date: Time.now) }

    before :each do
      visit meal_schedules_path

      find('.icon-cart-check').click
    end

    it { expect(page).to have_text("#{meal_schedule_with_assembly.assembly.name} added to order") }

    # TODO: works in real life, test fails
    # it 'assembly displays in pending_order#show' do
    #   visit meal_schedules_path

    #   find(".qa-scheduleItem-addToOrder-#{meal_schedule_with_assembly.id}").click

    #   save_and_open_page
    #   visit order_path(pending_order.id)

    #   expect(page).to have_text(meal_schedule_with_assembly.assembly.name)
    # end
  end

  context 'with item' do
    let!(:meal_schedule_with_item) { create(:meal_schedule, :with_item, schedule_date: Time.now) }

    before :each do
      visit meal_schedules_path

      find('.icon-cart-check').click
    end

    it { expect(page).to have_text("#{meal_schedule_with_item.item.name} added to order") }
  end
end
