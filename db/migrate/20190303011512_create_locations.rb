class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
