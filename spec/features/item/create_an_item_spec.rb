require 'rails_helper'

RSpec.feature 'Creates an Item' do
  let(:department) { create(:department, name: 'Produce') }
  let!(:item) { create(:item, department: department) }

  before do
    visit new_item_path
  end

  it 'displays the correct links' do
    expect(page).to have_text('New Item')
    expect(page).to have_link('Back', href: items_path)
    expect(page).to have_no_button('Destroy')
    expect(page).to have_button('Create Item')
  end

  it 'displays the correct message' do
    fill_in 'Name', with: '$texas'
    select 'Produce', from: 'Department'

    click_button 'Create Item'

    expect(page).to have_text('Item was created successfully')
    expect(page).to have_current_path(items_path)
  end
end
