class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @location = current_owner.locations.new
    @locations =current_owner.locations.by_name
  end

  # GET /locations/new
  def new
    @location = current_owner.locations.new
  end

  # GET /locations/1/edit
  def edit
    @location_departments = LocationDepartment.find_all_by_location_id(params[:id])
    @departments = Department.all
  end

  # POST /locations
  # POST /locations.json
  def create
    # byebug
    @location = current_owner.locations.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_url, notice: 'Location was created successfully' }
        format.json { render :show, status: :created, location: locations_url }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/:id
  # PATCH/PUT /locations/:id.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to locations_url, notice: 'Location was updated successfully' }
        format.json { render :show, status: :ok, location: locations_url }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_location
      @location = current_owner.locations.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :city, :state)
    end
end
