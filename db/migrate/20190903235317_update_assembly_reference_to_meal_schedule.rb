class UpdateAssemblyReferenceToMealSchedule < ActiveRecord::Migration[6.0]
  def change
    remove_reference :meal_schedules, :assembly_item, null: false, foreign_key: true
    add_reference :meal_schedules, :assembly, null: true, foreign_key: true
  end
end
