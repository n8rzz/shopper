# frozen_string_literal: true

class LocationDepartmentsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_location_department, only: [:update, :change_direction, :destroy]

  # POST /location_departments.json
  def create
    next_sort_order = LocationDepartment.get_next_sort_order(params[:location_id])
    @location_department = LocationDepartment.new(location_department_params)
    @location_department.sort_order = next_sort_order || 0

    respond_to do |format|
      if @location_department.save
        format.json { render json: LocationDepartment.find_all_by_location_id(params[:location_id]), status: :created }
      else
        format.json { render json: @location_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_departments/:id.json
  def update
    conflicting_record = LocationDepartment.find_by(
      location_id: location_department_params[:location_id],
      sort_order: location_department_params[:sort_order]
    )

    conflicting_record&.update(sort_order: location_department_params[:sort_order])

    respond_to do |format|
      if @location_department.update(location_department_params)
        format.json { render json: @location_department, status: :ok }
      else
        format.json { render json: @location_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /location_directions/:id/:direction.json
  def change_direction
    @record_to_move = LocationDepartment.find(params[:id])
    @displaced_record = LocationDepartment.find_displaced_record_by_direction(
      params[:direction],
      @record_to_move.sort_order,
      @record_to_move.location_id
    )
    displaced_record_sort_order = @displaced_record.sort_order
    @location_departments = LocationDepartment.find_all_by_location_id(@record_to_move.location_id)

    respond_to do |format|
      if update_records_to_move(@record_to_move, @displaced_record, displaced_record_sort_order)
        format.json { render json: @location_departments, status: :ok }
      else
        format.json { render json: @displaced_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_departments/:id.json
  def destroy
    location_id = @location_department.location_id
    removed_sort_order = @location_department.sort_order
    @location_department.destroy
    @location_departments = LocationDepartment.find_all_by_location_id(location_id)
    @location_departments.each do |item|
      unless item.sort_order <= removed_sort_order
        item.sort_order -= 1
        item.save
      end
    end

    respond_to do |format|
      format.json { render json: @location_departments, status: :ok }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location_department
    @location_department = LocationDepartment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_department_params
    params.require(:location_department).permit(:department_id, :location_id, :sort_order)
  end

  def update_records_to_move(record_to_move, displaced_record, displaced_record_sort_order)
    displaced_record.update(
      sort_order: record_to_move.sort_order
    ) && record_to_move.update(
      sort_order: displaced_record_sort_order
    )
  end
end
