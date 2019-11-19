require 'rails_helper'

RSpec.feature 'Destroy an item', js: true do
  let!(:item) { create(:item) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario 'visit item#index' do
    visit items_path
    click_link item.name

    accept_alert do
      click_link 'Destroy'
    end

    expect(page).to have_text('Item was successfully destroyed')
    expect(page).to_not have_text(item.name)
  end
end
