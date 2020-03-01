require 'rails_helper'

RSpec.feature 'Destroy Recipe', js: true do
  context 'when current_owner is a user' do
    let(:user) { create(:user) }
    let!(:recipe) { create(:recipe, ownable: user) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from recipe#edit' do
      visit edit_recipe_path(recipe.id)

      accept_alert do
        click_button('Destroy')
      end

      expect(page).to have_text('Recipe was destroyed successfully')
      expect(page).to have_current_path(recipes_path)
    end
  end

  context 'when current_owner is a group' do
    let(:user) { create(:user) }
    let(:group) { create(:group, user_ids: user.id) }
    let!(:recipe) { create(:recipe, ownable: group) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

    scenario 'from recipe#edit' do
      visit edit_recipe_path(recipe.id)

      accept_alert do
        click_button('Destroy')
      end

      expect(page).to have_text('Recipe was destroyed successfully')
      expect(page).to have_current_path(recipes_path)
    end
  end
end
