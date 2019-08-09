require 'rails_helper'

RSpec.feature 'Destroy Department', js: true do
  let!(:department) { create(:department) }

  scenario 'from department#index' do
    visit departments_path

    within first('.listItem') do
      accept_alert do
        click_button('Destroy')
      end
    end

    expect(page).to have_text('Department was successfully destroyed')
    expect(page).to_not have_text(department.name)
  end

  scenario 'from department#show' do
    visit departments_path
    click_link(department.name)

    expect(page).to_not have_link('Destroy')
  end
end
