class AddReferencesToMealSchedule < ActiveRecord::Migration[6.0]
  def change
    add_reference :meal_schedules, :item, null: false, foreign_key: true
    add_reference :meal_schedules, :assembly_item, foreign_key: true
    add_reference :meal_schedules, :order_item, foreign_key: true
  end
end
