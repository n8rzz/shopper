# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create an Recipe', js: true do
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

  context 'when user clicks `Add Recipe`' do
    before :each do
      visit assemblies_path

      click_link('Add Recipe')
    end

    it { expect(page).to have_current_path(new_recipe_path(assembly_id: assembly.id)) }
    it { expect(page).to have_select('Assembly', selected: assembly.name) }
  end
end
