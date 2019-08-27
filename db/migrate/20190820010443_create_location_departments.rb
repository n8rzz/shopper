class CreateLocationDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :location_departments do |t|
      t.references :location, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :sort_order

      t.timestamps
    end
  end
end
