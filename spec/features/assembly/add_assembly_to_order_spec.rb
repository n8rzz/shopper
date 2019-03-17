require 'rails_helper'

RSpec.feature 'Add assembly to Order' do
  let!(:assembly) { create(:assembly, :with_item) }

  scenario 'visit assembly#index' do
    visit assemblies_path

    click_button 'Add to order'

    expect(page).to have_text "#{assembly.name} added to pending order"
  end
end
