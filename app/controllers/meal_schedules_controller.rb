class MealSchedulesController < ApplicationController
  before_action :set_meal_schedule, only: [:destroy]

  # GET /meal_schedules
  def index
    @meal_schedules = MealSchedule.all
    @assemblies = Assembly.by_id
    @items = Item.by_id
  end

  def new
    @meal_schedule = MealSchedule.new(assembly_id: params[:assembly_id])

    puts @meal_schedule.to_json
  end

  # POST /meal_schedules
  # POST /meal_schedules.json
  def create
    @meal_schedule = MealSchedule.new(meal_schedule_params)

    respond_to do |format|
      if @meal_schedule.save
        format.html { render :index, notice: 'MealSchedule was added successfully' }
        format.json { render json: @meal_schedule, status: :created }
      else
        format.html { render :new }
        format.json { render json: @meal_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meal_schedule.destroy

    respond_to do |format|
      format.html { redirect_to meal_schedules_url, notice: 'MealSchedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_schedule
      @meal_schedule = MealSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_schedule_params
      params.require(:meal_schedule).permit(:schedule_date, :purchased, :meal_time, :item_id, :order_item_id, :assembly_id)
    end
end
