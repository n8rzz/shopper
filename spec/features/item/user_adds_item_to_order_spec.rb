require 'rails_helper'

RSpec.feature 'User visits Item#index' do
  let!(:item) { create(:item) }

  scenario 'visit item#index' do
    visit items_path

    within first('.listItem') do
      click_button 'Add to order'
    end

    expect(page).to have_text "#{item.name} added to pending order"
  end
end
