# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Update a Recipe', js: true do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  scenario '#edit template has correct links' do
    visit recipes_path

    click_link('Edit')

    expect(page).to have_text('Edit Recipe')
    expect(page).to have_link('Back', href: recipes_path)
    expect(page).to have_link('New', href: new_recipe_path)
    expect(page).to have_button('Save')
    expect(page).to have_button('Destroy')
  end

  scenario 'recipe updates correctly' do
    visit recipes_path

    click_link('Edit')

    fill_in('recipe_name', with: '$texas')
    click_button('Save')

    expect(page).to have_text('Recipe was updated successfully')
    expect(page).to have_text('$texas')
    expect(page).to have_current_path(recipes_path)
  end
end
