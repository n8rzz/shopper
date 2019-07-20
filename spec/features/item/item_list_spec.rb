require 'rails_helper'

RSpec.feature 'Item#index', js: true do
  let!(:item) { create(:item) }

  scenario 'visit item#index', js: true do
    visit items_path

    within first('.listItem') do
      expect(page).to have_text(item.name)
      expect(page).to have_link(item.name)
      expect(page).to have_button('Add to order')
    end
  end
end
