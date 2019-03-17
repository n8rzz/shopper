require 'rails_helper'

RSpec.feature 'Creates an Item' do
  let!(:item) { create(:item) }

  scenario 'visit item#new' do
    visit items_path
    click_link 'New Item'

    expect(page).to have_text 'New Item'
    expect(page).to have_link 'Back', href: items_path
    expect(page).to have_button 'Create Item'
  end

  scenario 'fill in new item form' do
    visit new_item_path

    fill_in 'Name', with: '$texas'
    select 'Produce', from: 'Department'

    click_button 'Create Item'

    expect(page).to have_text 'Item was created successfully'
    expect(page).to have_current_path(items_path)
  end
end
