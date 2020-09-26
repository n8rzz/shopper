# frozen_string_literal: true

class RecipeIngredientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_recipe
  before_action :set_recipe_ingredient, only: [:update, :destroy]

  # POST /recipes/:recipe_id/recipe_ingredient.json
  def create
    @recipe_ingredient = @recipe.recipe_ingredients.new(recipe_ingredient_params)

    respond_to do |format|
      if @recipe_ingredient.save
        format.json { render json: @recipe_ingredient, status: :created }
      else
        format.json { render json: @recipe_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/:recipe_id/recipe_ingredient/:recipe_ingredient_id.json
  def update
    respond_to do |format|
      if @recipe_ingredient.update(recipe_ingredient_params)
        format.json { render json: @recipe_ingredient, status: :ok }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/:recipe_id/recipe_ingredient/:recipe_ingredient_id.json
  def destroy
    @recipe_ingredient.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_recipe
    @recipe = current_owner.recipes.find(params[:recipe_id])
  end

  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:recipe_ingredient_id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:name, :qty_unit, :qty_value, item_ids: [])
  end
end
