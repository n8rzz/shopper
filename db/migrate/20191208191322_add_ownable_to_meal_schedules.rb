class AddOwnableToMealSchedules < ActiveRecord::Migration[6.0]
  def change
    add_reference :meal_schedules, :ownable, polymorphic: true
  end
end
