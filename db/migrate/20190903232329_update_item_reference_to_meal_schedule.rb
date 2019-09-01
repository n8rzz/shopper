class UpdateItemReferenceToMealSchedule < ActiveRecord::Migration[6.0]
  def change
    change_column_null :meal_schedules, :item_id, true
  end
end
