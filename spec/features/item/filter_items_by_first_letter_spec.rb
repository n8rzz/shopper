require 'rails_helper'

RSpec.feature 'Filter Items by first letter', js: true do
  let(:user) { create(:user) }
  let(:produce) { create(:department, name: 'Produce', ownable: user) }
  let(:meat) { create(:department, name: 'Meat', ownable: user) }
  let!(:produce_item) { create(:item, name: 'banana', department: produce, ownable: user) }
  let!(:meat_item) { create(:item, name: 'hot dog', department: meat, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before do
    visit items_path
    click_link('Filter')
  end

  it { expect(page).to have_link('Filter') }
  it { expect(page).to have_select('filter-item-by-first-letter') }

  it 'filters items by first letter' do
    find('option[value="b"]').click

    expect(page).to have_text(produce_item.name)
    expect(page).to_not have_text(meat_item.name)
  end

  it 'updates list when different filter is selected' do
    find('option[value="h"]').click

    expect(page).to_not have_text(produce_item.name)
    expect(page).to have_text(meat_item.name)
  end
end
