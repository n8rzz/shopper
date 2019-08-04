require 'rails_helper'

RSpec.feature 'Add assembly to Order', js: true do
  # TODO: currently broken
  # assembly is created fine, but doesnt show in list
  # let!(:assembly) { create(:assembly, :with_item) }

  # scenario 'adds all items from assembly to an order' do
  #   visit assemblies_path

  #   within first('.listItem') do
  #     click_button 'Add to order'
  #   end

  #   expect(page).to have_text("#{assembly.name} added to pending order")
  # end
end
