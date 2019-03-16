require 'rails_helper'

RSpec.feature 'User creates a Department' do
  scenario 'they see the Department on the page' do
    visit new_department_path

    fill_in 'Name', with: 'Icebox'
    click_button 'Create Department'

    assert_text 'Department was successfully created'
  end
end
