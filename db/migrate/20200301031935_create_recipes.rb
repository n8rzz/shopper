class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.integer :prep_time
      t.integer :cook_time
      t.integer :yield_value
      t.string :yield_unit
      t.references :ownable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
