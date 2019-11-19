require 'rails_helper'

RSpec.feature 'Create an Assembly', js: true do
  let!(:item_apple) { create(:item, name: 'Apple') }
  let!(:item_banana) { create(:item, name: 'Banana') }
  let!(:item_cashew) { create(:item, name: 'Cashew') }
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  before :each do
    visit assemblies_path
    click_link('New Assembly')
  end

  it { expect(page).to have_link('Back') }
  it { expect(page).to have_unchecked_field('Apple') }
  it { expect(page).to have_unchecked_field('Banana') }
  it { expect(page).to have_unchecked_field('Cashew') }

  scenario 'fill in assembly form' do
    fill_in 'Name', with: 'Fruit Salad'
    check 'Apple'
    check 'Banana'
    click_button 'Create Assembly'

    expect(page).to have_text('Assembly was created successfully')
    expect(page).to have_text('Fruit Salad')
    expect(page).to have_text('Items:2')
  end
end
