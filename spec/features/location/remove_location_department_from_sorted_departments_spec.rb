require 'rails_helper'

RSpec.feature 'Remove location_department to sorted departments', js: true do
  let!(:location) { create(:location) }
  let!(:department_meat) { create(:department, name: 'meat') }
  let!(:department_produce) { create(:department, name: 'produce') }
  let!(:department_bakery) { create(:department, name: 'bakery') }
  let!(:location_department_meat) { create(:location_department, location_id: location.id, department_id: department_meat.id, sort_order: 0) }
  let!(:location_department_produce) { create(:location_department, location_id: location.id, department_id: department_produce.id, sort_order: 1) }

  context 'removes department from sorted group' do
    before :each do
      visit edit_location_path(location.id)

      find(".js-sortedDepartment-remove-#{location_department_produce.id}").click
    end

    it { expect(page).to have_selector('.js-sortedDepartmentList > li', count: 1) }
    it { expect(page).to have_selector('.js-nonSortedDepartmentList > li', count: 2) }
  end

  context 'updates #sort_order of remaining items' do
    before :each do
      visit edit_location_path(location.id)

      find(".js-sortedDepartment-remove-#{location_department_meat.id}").click

      # FIXME: this test passes now, but this is wrong
      sleep 1
    end

    it { expect(location_department_produce.reload.sort_order).to eq(0) }
  end
end
