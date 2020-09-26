class CreateRecipeInstructions < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_instructions do |t|
      t.integer :sort_order, default: 0
      t.string :text, null: false
      t.references :recipe, null: false

      t.timestamps
    end
  end
end
