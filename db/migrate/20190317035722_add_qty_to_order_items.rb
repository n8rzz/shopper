class AddQtyToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :qty, :integer, default: 1
  end
end
