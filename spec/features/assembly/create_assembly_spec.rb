require 'rails_helper'

RSpec.feature 'Create an Assembly', js: true do
  let(:user) { create(:user) }
  let!(:item_apple) { create(:item, name: 'Apple', ownable: user) }
  let!(:item_banana) { create(:item, name: 'Banana', ownable: user) }
  let!(:item_cashew) { create(:item, name: 'Cashew', ownable: user) }

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

  context 'fill in assembly form' do
    before :each do
      fill_in 'Name', with: 'Fruit Salad'
      check 'Apple'
      check 'Banana'

      click_button('Create Assembly')
    end

    it { expect(page).to have_text('Assembly was created successfully') }
    # it { expect(page).to have_text('Fruit Salad') }
    # it { expect(page).to have_text('Items:2') }
  end
end
