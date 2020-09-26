# frozen_string_literal: true

class RecipeInstructionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_recipe
  before_action :set_recipe_instruction, only: [:update, :destroy]

  # POST /recipes/:recipe_id/recipe_instruction.json
  def create
    @recipe_instruction = @recipe.recipe_instructions.new(recipe_instruction_params)

    respond_to do |format|
      if @recipe_instruction.save
        format.json { render json: @recipe_instruction, status: :created }
      else
        format.json { render json: @recipe_instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/:recipe_id/recipe_instruction/:recipe_instruction_id.json
  def update
    respond_to do |format|
      if @recipe_instruction.update(recipe_instruction_params)
        format.json { render json: @recipe_instruction, status: :ok }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/:recipe_id/recipe_instruction/:recipe_instruction_id.json
  def destroy
    @recipe_instruction.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_recipe
    @recipe = current_owner.recipes.find(params[:recipe_id])
  end

  def set_recipe_instruction
    @recipe_instruction = RecipeInstruction.find(params[:recipe_instruction_id])
  end

  def recipe_instruction_params
    params.require(:recipe_instruction).permit(:sort_order, :text)
  end
end
