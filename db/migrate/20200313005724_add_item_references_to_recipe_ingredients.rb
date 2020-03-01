class AddItemReferencesToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :recipe_ingredient, null: true, foreign_key: true
  end
end
