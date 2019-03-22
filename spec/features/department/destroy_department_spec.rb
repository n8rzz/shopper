require 'rails_helper'

RSpec.feature 'Destroy Department' do
  let!(:department) { create(:department) }

  scenario 'visit department#index' do
    visit departments_path

    expect(page).to have_text 'Departments'
    expect(page).to have_button 'New Department'
    expect(page).to have_button 'Destroy'
  end
end
