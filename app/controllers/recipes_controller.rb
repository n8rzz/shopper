# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = current_owner.recipes.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = current_owner.recipes.new
    @recipe.recipe_instructions.build

    return if params[:assembly_id].nil?

    @recipe.assembly_id = params[:assembly_id]
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_owner.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was created successfully' }
        format.json { render json: @recipe, include: [:recipe_ingredients, :recipe_instructions], status: :created }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipes_path, notice: 'Recipe was updated successfully' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was destroyed successfully' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = current_owner.recipes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      :prep_time,
      :cook_time,
      :yield_value,
      :yield_unit,
      :ownable_id,
      :assembly_id,
      recipe_ingredients_attributes: [:id, :name, :qty_unit, :qty_value, :item_id],
      recipe_instructions_attributes: [:id, :sort_order, :text]
    )
  end
end
