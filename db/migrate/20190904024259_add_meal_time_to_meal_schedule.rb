class AddMealTimeToMealSchedule < ActiveRecord::Migration[6.0]
  def change
    add_column :meal_schedules, :meal_time, :string
  end
end
