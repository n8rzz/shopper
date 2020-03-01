class AddRecipeReferenceToAssembly < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipes, :assembly, null: true, foreign_key: true
  end
end
