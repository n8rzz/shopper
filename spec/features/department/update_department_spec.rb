require 'rails_helper'

RSpec.feature 'Update Department', js: true do
  let!(:department) { create(:department) }

  scenario 'has the correct links' do
    visit '/departments'
    click_link department.name

    expect(page).to have_text('Edit Department')
    expect(page).to have_link('Back', href: departments_path)
    expect(page).to have_link('New', href: new_department_path)
    expect(page).to have_button('Update')
  end

  scenario 'They see the department updates on the page' do
    visit departments_path
    click_on department.name

    fill_in 'Name', with: '$texas'
    click_button 'Update Department'

    expect(page).to have_text 'Department was updated successfully'
    expect(page).to have_current_path(departments_path)
  end
end
