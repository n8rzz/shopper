require 'rails_helper'

RSpec.feature 'Edit an Assembly', js: true do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'updates a record' do
    visit assemblies_path
    visit edit_assembly_path(assembly.id)

    fill_in 'Name', with: '$Texas'
    click_button 'Update Assembly'

    expect(page).to have_text('Assembly was updated successfully')
  end
end
