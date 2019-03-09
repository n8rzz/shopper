class AddPickedToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :picked, :boolean, default: false
  end
end
