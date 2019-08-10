require 'rails_helper'

RSpec.feature 'Group Items by Department', js: true do
  let(:produce) { create(:department, name: 'Produce') }
  let(:meat) { create(:department, name: 'Meat') }
  let!(:produce_item) { create(:item, department: produce) }
  let!(:meat_item) { create(:item, department: meat) }

  before do
    visit items_path
  end

  it { expect(page).to have_link('Department') }

  context 'when clicking on Department link' do
    it 'Department names are headings' do
      click_link 'Department'

      expect(page).to have_selector('h2', text: produce.name)
      expect(page).to have_selector('h2', text: meat.name)
    end
  end
end
