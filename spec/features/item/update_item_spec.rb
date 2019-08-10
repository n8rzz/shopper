require 'rails_helper'

RSpec.feature 'Update an Item', js: true do
  let!(:item) { create(:item) }

  scenario 'visit item#edit' do
    visit items_path
    click_link item.name

    expect(page).to have_text 'Editing Item'
    expect(page).to have_link 'Back', href: items_path
    expect(page).to have_button 'Update Item'
  end

  scenario 'the item updates are displayed' do
    visit items_path
    click_on item.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Item'

    expect(page).to have_text('Item was updated successfully')
    expect(page).to have_current_path(items_path)
  end
end
