require 'rails_helper'

RSpec.feature 'Item#index', js: true do
  let!(:item) { create(:item) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario 'visit item#index', js: true do
    visit items_path

    within first('.listItem') do
      expect(page).to have_text(item.name)
      expect(page).to have_link(item.name)
      expect(page).to have_button('Add to order')
    end
  end
end
