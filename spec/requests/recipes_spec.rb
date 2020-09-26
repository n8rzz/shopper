# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'GET /recipes' do
    context 'renders #index template' do
      before :each do
        get '/recipes'
      end

      it { expect(response).to render_template(:index) }
      it { expect(response).to_not render_template(:show) }
    end
  end

  context 'GET /recipes/new' do
    context 'renders #new template' do
      before :each do
        get '/recipes/new'
      end

      it { expect(response).to render_template(:new) }
    end
  end

  context 'POST /recipes' do
    describe 'server route' do
      before :each do
        post '/recipes', params: {
          recipe: attributes_for(:recipe),
          recipe_instructions_attributes: [
            attributes_for(:recipe_instruction),
            attributes_for(:recipe_instruction)
          ]
        }
      end

      it { expect(response).to redirect_to(recipes_path) }

      it 'and redirects to the Recipes\'s page' do
        follow_redirect!

        expect(response).to render_template(:index)
      end
    end

    describe '.json route' do
      let(:item) { create(:item, ownable: user) }
      let(:instruction_1) { attributes_for(:recipe_instruction, sort_order: 0) }
      let(:instruction_2) { attributes_for(:recipe_instruction, sort_order: 1) }
      let(:ingredient_1) { attributes_for(:recipe_ingredient) }
      let(:ingredient_2) { attributes_for(:recipe_ingredient, name: nil, item_id: item.id) }

      before :each do
        post '/recipes.json', params: {
          recipe: attributes_for(
            :recipe,
            recipe_ingredients_attributes: [ingredient_1, ingredient_2],
            recipe_instructions_attributes: [instruction_1, instruction_2]
          )
        }
      end

      it { expect(response.status).to eq(201) }
      it 'includes correct #recipe_ingredients' do
        parsed_response = JSON.parse(response.body)
        recipe_ingredients_response = parsed_response['recipe_ingredients']

        expect(recipe_ingredients_response.count).to eq(2)
      end

      it 'includes correct #recipe_instructions' do
        parsed_response = JSON.parse(response.body)
        recipe_instructions_response = parsed_response['recipe_instructions']

        expect(recipe_instructions_response.count).to eq(2)
      end
    end
  end

  context 'PUT /recipes' do
    let(:recipe) { create(:recipe, name: 'Honey Hole', ownable: user) }

    before :each do
      put recipe_path(recipe.id), params: { recipe: { name: 'Jackson Hole' }}
    end

    it { expect(response).to redirect_to(recipes_path) }

    it 'and redirects to the Recipes\'s page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end

  context 'DELETE /recipes' do
    let(:recipe) { create(:recipe, ownable: user) }

    before :each do
      delete recipe_path(recipe.id)
    end

    it { expect(response).to redirect_to(recipes_path) }

    it 'and redirects to the Recipes\'s page' do
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end
end
