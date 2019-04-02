require 'rails_helper'

RSpec.feature 'Edit an Assembly' do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'and clicks an assembly at assembly#index' do
    visit assemblies_path

    click_link assembly.name

    expect(page).to have_current_path(edit_assembly_path(assembly.id))
  end

  scenario 'updates assembly' do
    visit edit_assembly_path(assembly.id)

    fill_in 'Name', with: '$Texas'
    click_button 'Update Assembly'

    expect(page).to have_text('Assembly was updated successfully')
  end
end
