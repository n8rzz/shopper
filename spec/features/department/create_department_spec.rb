require 'rails_helper'

RSpec.feature 'Create Department' do
  let!(:department) { create(:department) }

  scenario 'has the correct links' do
    visit new_department_path

    expect(page).to have_text 'New Department'
    expect(page).to have_link 'Back', href: departments_path
    expect(page).to have_button 'Create Department'
  end

  scenario 'they see the Department on the page' do
    visit new_department_path

    fill_in 'Name', with: 'Icebox'
    click_button 'Create Department'

    expect(page).to have_text 'Department was successfully created'
    expect(page).to have_current_path(departments_path)
  end
end
