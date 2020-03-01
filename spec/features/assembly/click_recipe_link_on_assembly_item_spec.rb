# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'click recpie link on assembly item', js: true do
  let(:user) { create(:user) }
  let(:department) { create(:department, ownable: user) }
  let(:item1) { create(:item, department: department, ownable: user) }
  let(:item2) { create(:item, department: department, ownable: user) }
  let!(:assembly) { create(:assembly, item_ids: [item1.id, item2.id], ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'visit assembly#index' do
    before :each do
      visit assemblies_path
    end

    it { expect(page).to have_text(assembly.name) }
    it { expect(page).to have_text("Items:#{assembly.items.count}") }
    it { expect(page).to have_button('Add to order') }
    it { expect(find(".js-assembly-#{assembly.id}")).to have_link('Recipe') }
    it { expect(page).to have_link('Schedule') }
    it { expect(page).to have_link('Edit') }
  end

  context 'when a recipe does not exist for an assembly' do
    before :each do
      visit assemblies_path
    end

    it { expect(page).to have_link('Add Recipe', href: new_recipe_path(assembly_id: assembly.id)) }
  end

  context 'when a recipe exists for an assembly' do
    let!(:recipe) { create(:recipe, :without_name, ownable: user, assembly_id: assembly.id) }

    before :each do
      visit assemblies_path
    end

    it { expect(page).to have_link('Recipe', href: recipe_path(recipe.id)) }
  end
end
