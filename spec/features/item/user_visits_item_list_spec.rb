require 'rails_helper'

RSpec.feature 'User visits Item#index' do
  let!(:item) { create(:item) }

  scenario 'visit item#index' do
    visit items_path

    within first('.listItem') do
      expect(page).to have_text item.name
      expect(page).to have_link item.name, href: edit_item_path(item.id)
      expect(page).to have_button 'Add to order'
    end
  end
end
