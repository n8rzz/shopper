class AddDepartmentRefToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :department, foreign_key: true
  end
end
