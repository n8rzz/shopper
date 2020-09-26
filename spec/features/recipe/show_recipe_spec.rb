# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Show Recipe', js: true do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'renders the correct links' do
    let!(:recipe) { create(:recipe, ownable: user) }

    before :each do
      visit recipes_path

      click_link(recipe.name)
    end

    it { expect(page).to have_link('Edit', href: edit_recipe_path(recipe.id)) }
    it { expect(page).to have_link('Back', href: recipes_path) }
    it { expect(page).to have_text("#{recipe.prep_time} minutes") }
    it { expect(page).to have_text("#{recipe.cook_time} minutes") }
    it { expect(page).to have_text("#{recipe.yield_value} #{recipe.yield_unit}") }
  end

  context 'renders the correct heading' do
    context 'when associated with an assembly' do
      let(:assembly) { create(:assembly, ownable: user) }
      let(:recipe) { create(:recipe, name: nil, ownable: user, assembly_id: assembly.id) }

      before :each do
        visit recipe_path(recipe.id)
      end

      it { expect(page).to have_selector('h1', text: assembly.name.capitalize) }
    end

    context 'when not associated with an assembly' do
      let!(:recipe) { create(:recipe, ownable: user) }

      before :each do
        visit recipe_path(recipe.id)
      end

      it { expect(page).to have_selector('h1', text: recipe.name.capitalize) }
    end
  end
end
