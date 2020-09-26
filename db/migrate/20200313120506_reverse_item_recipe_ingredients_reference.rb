class ReverseItemRecipeIngredientsReference < ActiveRecord::Migration[6.0]
  def change
    remove_reference :items, :recipe_ingredient
    add_reference :recipe_ingredients, :item, null: true, foreign_key: true
  end
end
