# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecipeIngredients', type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'POST /recipes/:recipe_id/recipe_ingredients' do
    context 'with an item reference' do
      let(:item) { create(:item, ownable: user)}
      let(:recipe_ingredient_attributes) { attributes_for(:recipe_ingredient, item_id: item.id) }

      before :each do
        post "/recipes/#{recipe.id}/recipe_ingredient.json", params: {
          recipe_ingredient: recipe_ingredient_attributes
         }
      end

      it { expect(response.status).to eq(201) }
      it 'returns the created record' do
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['recipt_id']).to eq(recipe_ingredient_attributes[:recipt_id])
        expect(parsed_response['name']).to eq(recipe_ingredient_attributes[:name])
      end
    end

    context 'without an item reference' do
      let(:recipe_ingredient_attributes) { attributes_for(:recipe_ingredient) }

      before :each do
        post "/recipes/#{recipe.id}/recipe_ingredient.json", params: {
          recipe_ingredient: recipe_ingredient_attributes
         }
      end

      it { expect(response.status).to eq(201) }
      it 'returns the created record' do
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['recipt_id']).to eq(recipe_ingredient_attributes[:recipt_id])
        expect(parsed_response['name']).to eq(recipe_ingredient_attributes[:name])
      end
    end
  end

  context 'PUT /recipes/:recipe_id/recipe_ingredient/:recipe_ingredient_id' do
    let(:recipe_ingredient) { create(:recipe_ingredient, recipe_id: recipe.id) }

    before :each do
      put "/recipes/#{recipe.id}/recipe_ingredient/#{recipe_ingredient.id}.json", params: {
        recipe_ingredient: {
          name: recipe_ingredient.name,
          qty_value: '99',
          qty_unit: recipe_ingredient.qty_unit
        }
       }
    end

    it { expect(response.status).to eq(200) }
    it 'returns the updated record' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['qty_value']).to eq('99')
    end
  end

  context 'DELETE /recipes/:recipe_id/recipe_ingredient/:recipe_ingredient_id' do
    let(:recipe_ingredient) { create(:recipe_ingredient, recipe_id: recipe.id) }

    before :each do
      delete "/recipes/#{recipe.id}/recipe_ingredient/#{recipe_ingredient.id}.json"
    end

    it { expect(response.status).to eq(204) }
  end
end
