require 'rails_helper'

RSpec.feature 'Add location_department to sorted departments', js: true do
  let(:user) { create(:user) }
  let!(:location) { create(:location, ownable: user) }
  let!(:department_meat) { create(:department, name: 'meat') }
  let!(:department_produce) { create(:department, name: 'produce') }
  let!(:department_bakery) { create(:department, name: 'bakery') }
  let!(:location_department_meat) { create(:location_department, location_id: location.id, department_id: department_meat.id, sort_order: 0) }
  let!(:location_department_produce) { create(:location_department, location_id: location.id, department_id: department_produce.id, sort_order: 1) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'displays departments without a #sort_order' do
    before :each do
      visit edit_location_path(location.id)
    end

    it { expect(page).to have_selector('.js-sortedDepartmentList > li', count: 2) }
    it { expect(page).to have_selector('.js-nonSortedDepartmentList > li', count: 1) }
  end

  context 'adds department to sorted group' do
    before :each do
      visit edit_location_path(location.id)

      find(".js-addDepartmentToSort-#{department_bakery.id}").click
    end

    it { expect(page).to have_selector('.js-sortedDepartmentList > li', count: 3) }
    it { expect(page).to have_selector('.js-nonSortedDepartmentList > li', count: 0) }
  end
end
