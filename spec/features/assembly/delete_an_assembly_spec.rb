require 'rails_helper'

RSpec.feature 'Delete an Assembly', js: true do
  let!(:assembly) { create(:assembly, :with_item) }

  # scenario 'clicks an assembly at assembly#index' do
  #   visit assemblies_path

  #   within first('.listItem') do
  #     click_link('Edit Assembly')
  #   end

  #   expect(page).to have_current_path(edit_assembly_path(assembly.id))
  # end

  scenario 'clicks delete link' do
    visit edit_assembly_path(assembly.id)

    accept_alert do
      click_link 'Destroy'
    end

    expect(page).to have_text 'Assembly was deleted successfully'
  end
end
