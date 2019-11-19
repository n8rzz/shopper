require 'rails_helper'

RSpec.feature 'Delete a Location', js: true do
  let!(:location) { create(:location) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario 'from location#index' do
    visit locations_path

    within first('.listItem') do
      accept_alert do
        click_button('Destroy')
      end
    end

    expect(page).to have_text('Location was successfully destroyed')
    expect(page).to_not have_text(location.name)
  end

  scenario 'from location#show' do
    visit locations_path
    click_link(location.name)

    accept_alert do
      click_link('Destroy')
    end

    expect(page).to have_text('Location was successfully destroyed')
    expect(page).to_not have_text(location.name)
  end
end
