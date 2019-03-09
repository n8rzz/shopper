class AddDepartmentRefToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :department, foreign_key: true
  end
end
