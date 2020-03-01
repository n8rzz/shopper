# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecipeInstructions', type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, ownable: user) }

  before do
    sign_in user
  end

  after do
    sign_out user
  end

  context 'POST /recipes/:recipe_id/recipe_instruction' do
    let(:recipe_instruction_attributes) { attributes_for(:recipe_instruction) }

    before :each do
      post "/recipes/#{recipe.id}/recipe_instruction.json", params: {
        recipe_instruction: recipe_instruction_attributes
       }
    end

    it { expect(response.status).to eq(201) }
    it 'returns the created record' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['recipt_id']).to eq(recipe_instruction_attributes[:recipt_id])
      expect(parsed_response['sort_order']).to eq(recipe_instruction_attributes[:sort_order])
      expect(parsed_response['text']).to eq(recipe_instruction_attributes[:text])
    end
  end

  context 'PUT /recipes/:recipe_id/recipe_instruction/:recipe_instruction_id' do
    let(:recipe_instruction) { create(:recipe_instruction, recipe_id: recipe.id) }

    before :each do
      put "/recipes/#{recipe.id}/recipe_instruction/#{recipe_instruction.id}.json", params: {
        recipe_instruction: {
          sort_order: 99,
          text: recipe_instruction.text
        }
       }
    end

    it { expect(response.status).to eq(200) }
    it 'returns the updated record' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['sort_order']).to eq(99)
      expect(parsed_response['text']).to eq(recipe_instruction[:text])
    end
  end

  context 'DELETE /recipes/:recipe_id/recipe_instruction/:recipe_instruction_id' do
    let(:recipe_instruction) { create(:recipe_instruction, recipe_id: recipe.id) }

    before :each do
      delete "/recipes/#{recipe.id}/recipe_instruction/#{recipe_instruction.id}.json"
    end

    it { expect(response.status).to eq(204) }
  end
end
