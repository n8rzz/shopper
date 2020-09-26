# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create an Recipe', js: true do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'when user clicks `New Recipe`' do
    before :each do
      visit recipes_path

      click_link('New Recipe')
    end

    it { expect(page).to have_link('Back', href: recipes_path) }
    it { expect(page).to have_no_link('Edit') }
    it { expect(page).to have_no_link('Destroy') }
  end

  context 'when a user fills in Recipe form' do
    before :each do
      visit new_recipe_path

      fill_in('recipe_name', with: 'Icebox')
      fill_in('Description', with: 'A very cold dish')
      fill_in('Prep time', with: '20')
      fill_in('Cook time', with: '90')
      fill_in('Yield value', with: '3')
      fill_in('Yield unit', with: 'monkeys')

      click_button('Save')
    end

    it { expect(page).to have_text('Recipe was created successfully') }
    it { expect(page).to have_current_path(recipes_path) }
  end
end
