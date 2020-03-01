# frozen_string_literal: true

class AssembliesController < ApplicationController
  before_action :set_assembly, only: [:show, :edit, :update, :destroy]
  before_action :set_owner_items

  # GET /assemblies
  # GET /assemblies.json
  def index
    @assemblies = current_owner.assemblies.all.order('name ASC')
    @assembly_items = AssemblyItem.all
    @departments = current_owner.departments.all
    @items = current_owner.items.all
    @recipes = current_owner.recipes.all
  end

  # GET /assemblies/new
  def new
    @assembly = current_owner.assemblies.new
  end

  # GET /assemblies/1/edit
  def edit; end

  # POST /assemblies
  # POST /assemblies.json
  def create
    @assembly = current_owner.assemblies.new(assembly_params)

    respond_to do |format|
      if @assembly.save
        format.html { redirect_to assemblies_path, notice: 'Assembly was created successfully' }
        format.json { render :show, status: :created, location: assemblies_path }
      else
        format.html { render :new }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assemblies/1
  # PATCH/PUT /assemblies/1.json
  def update
    respond_to do |format|
      if @assembly.update(assembly_params)
        format.html { redirect_to assemblies_path, notice: 'Assembly was updated successfully' }
        format.json { render :show, status: :ok, location: assemblies_path }
      else
        format.html { render :edit }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assemblies/1
  # DELETE /assemblies/1.json
  def destroy
    @assembly.destroy
    respond_to do |format|
      format.html { redirect_to assemblies_url, notice: 'Assembly was deleted successfully' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assembly
    @assembly = current_owner.assemblies.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assembly_params
    params.require(:assembly).permit(:name, item_ids: [], order_item_ids: [])
  end

  def set_owner_items
    @owner_items = current_owner.items.by_name
  end
end
