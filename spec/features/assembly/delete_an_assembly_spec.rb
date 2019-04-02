require 'rails_helper'

RSpec.feature 'Delete an Assembly' do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'clicks an assembly at assembly#index' do
    visit assemblies_path
    click_link assembly.name

    expect(page).to have_current_path(edit_assembly_path(assembly.id))
  end

  scenario 'clicks delete link' do
    visit edit_assembly_path(assembly.id)

    click_link 'Destroy'

    expect(page).to have_text 'Assembly was deleted successfully'
  end
end
