require 'rails_helper'

RSpec.feature 'Create an OrderItem from MealSchedules', js: true do
  context 'as a non-grouped user' do
    let(:user) { create(:user) }
    let!(:pending_order) { create(:order, :pending, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    describe 'with assembly' do
      let(:item) { create(:item, ownable: user) }
      let(:assembly) { create(:assembly, item_ids: [item.id], ownable: user)}
      let!(:meal_schedule_with_assembly) { create(:meal_schedule, assembly_id: assembly.id, schedule_date: Time.now, ownable: user) }

      before :each do
        visit meal_schedules_path

        find('.icon-cart-check').click
      end

      it { expect(page).to have_text("#{meal_schedule_with_assembly.assembly.name} added to order") }

      # TODO: works in real life, test is flakey
      it 'assembly displays in pending_order#show' do
        visit meal_schedules_path

        find(".qa-scheduleItem-addToOrder-#{meal_schedule_with_assembly.id}").click

        visit order_path(pending_order.id)

        expect(page).to have_text(meal_schedule_with_assembly.assembly.name)
      end
    end

    describe 'with item' do
      let(:item) { create(:item, ownable: user) }
      let!(:meal_schedule_with_item) { create(:meal_schedule, item_id: item.id, schedule_date: Time.now, ownable: user) }

      before :each do
        visit meal_schedules_path

        find('.icon-cart-check').click
      end

      it { expect(page).to have_text("#{meal_schedule_with_item.item.name} added to order") }
    end
  end

  context 'as a group user' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: [user.id]) }
    let(:item) { create(:item, ownable: group) }
    let!(:pending_order) { create(:order, :pending, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    describe 'with assembly' do
      let(:assembly) { create(:assembly, item_ids: [item.id], ownable: group)}
      let!(:meal_schedule_with_assembly) { create(:meal_schedule, assembly_id: assembly.id, schedule_date: Time.now, ownable: group) }

      before :each do
        visit meal_schedules_path

        find('.icon-cart-check').click
      end

      it { expect(page).to have_text("#{meal_schedule_with_assembly.assembly.name} added to order") }

      # TODO: works in real life, test is flakey
      it 'assembly displays in pending_order#show' do
        visit meal_schedules_path

        find(".qa-scheduleItem-addToOrder-#{meal_schedule_with_assembly.id}").click

        visit order_path(pending_order.id)

        expect(page).to have_text(meal_schedule_with_assembly.assembly.name)
      end
    end

    describe 'with item' do
      let!(:meal_schedule_with_item) { create(:meal_schedule, item_id: item.id, schedule_date: Time.now, ownable: group) }

      before :each do
        visit meal_schedules_path

        find('.icon-cart-check').click
      end

      it { expect(page).to have_text("#{meal_schedule_with_item.item.name} added to order") }
    end
  end
end
