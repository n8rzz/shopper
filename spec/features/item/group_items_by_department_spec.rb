require 'rails_helper'

RSpec.feature 'Group Items by Department', js: true do
  let(:user) { create(:user) }
  let(:produce) { create(:department, name: 'Produce', ownable: user) }
  let(:meat) { create(:department, name: 'Meat', ownable: user) }
  let!(:produce_item) { create(:item, department: produce, ownable: user) }
  let!(:meat_item) { create(:item, department: meat, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before do
    visit items_path
  end

  it { expect(page).to have_link('Department') }

  context 'when clicking on Department link' do
    it 'Department names are headings' do
      click_link('Department')

      expect(page).to have_selector('h2', text: produce.name)
      expect(page).to have_selector('h2', text: meat.name)
    end
  end
end
