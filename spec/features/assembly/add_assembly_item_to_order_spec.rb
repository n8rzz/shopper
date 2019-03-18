require 'rails_helper'

RSpec.feature 'Add assembly item to Order', js: true do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'adds a single item from an assembly to an order' do
    visit assemblies_path

    first('.js-accordionList-trigger').click

    within first('.listItem-child') do
      click_button('Add Item to order')
    end

    expect(page).to have_text('Item added to order successfully')
  end
end
