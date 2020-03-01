# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Recipes#index', js: true do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe, ownable: user) }
  let!(:non_owned_recipe) { create(:recipe, :ownable_user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'click recipes link in menu' do
    before :each do
      visit root_path

      click_link('Recipes')
    end

    it { expect(page).to have_current_path(recipes_path) }
  end

  context 'visits recipes#index' do
    before :each do
      visit recipes_path
    end

    it { expect(page).to have_text('Recipes') }
    it { expect(page).to have_link('New Recipe') }
    it { expect(page).to have_link(recipe.name) }
    it { expect(page).to have_link('Edit', href: edit_recipe_path(recipe.id)) }
    it { expect(page).to_not have_button('Destroy') }
    it { expect(page).to_not have_text(non_owned_recipe.name) }
  end

  context 'clicking recipe link goes to recipe#show' do
    before :each do
      visit recipes_path

      click_link(recipe.name)
    end

    it { expect(page).to have_current_path(recipe_path(recipe.id)) }
  end


  context 'should render the correct display_name' do
    context 'when a recipe is associated to an assembly' do
      let(:assembly) { create(:assembly, ownable: user) }
      let!(:recipe) { create(:recipe, name: nil, ownable: user, assembly_id: assembly.id) }

      before :each do
        visit recipes_path
      end

      it { expect(page).to have_link(recipe.assembly.name, href: recipe_path(recipe.id)) }
    end

    context 'when a recipe is not associated to an assembly' do
      let!(:recipe) { create(:recipe, ownable: user) }

      before :each do
        visit recipes_path
      end

      it { expect(page).to have_link(recipe.name, href: recipe_path(recipe.id)) }
    end
  end
end
