require 'rails_helper'

RSpec.feature 'User updates a Department' do
  let!(:department) { create(:department) }

  scenario 'visit department#edit' do
    visit '/departments'
    click_link department.name

    expect(page).to have_text 'Editing Department'
    expect(page).to have_link 'Back', href: departments_path
    expect(page).to have_button 'Update Department'
  end

  scenario 'They see the department updates on the page' do
    visit departments_path
    click_on department.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Department'

    expect(page).to have_text 'Department was updated successfully'
  end
end
