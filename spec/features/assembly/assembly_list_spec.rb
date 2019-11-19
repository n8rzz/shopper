require 'rails_helper'

RSpec.feature 'Assembly#index', js: true do
  let!(:assembly) { create(:assembly, :with_item) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario 'visit assembly#index' do
    visit assemblies_path

    expect(page).to have_text(assembly.name)
    expect(page).to have_text("Items:#{assembly.items.count}")
    expect(page).to have_button('Add to order')
    expect(page).to have_link('Schedule')
    expect(page).to have_link('Edit')
  end
end
