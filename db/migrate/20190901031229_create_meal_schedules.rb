class CreateMealSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_schedules do |t|
      t.datetime :schedule_date, null: false
      t.boolean :purchased, default: false

      t.timestamps
    end
  end
end
