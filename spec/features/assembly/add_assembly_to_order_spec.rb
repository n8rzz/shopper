require 'rails_helper'

RSpec.feature 'Add assembly to Order' do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'add assembly to order' do
    visit assemblies_path

    click_button 'Add to order'

    expect(page).to have_text "#{assembly.name} added to pending order"
  end

  # xscenario 'add assembly_item to order', js: true do
  #   visit assemblies_path

  #   first('.js-accordionList-trigger').click
  #   first('.listItem-child', visible: false).click_button('Add item to order')
  # end
end
