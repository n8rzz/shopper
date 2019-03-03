class AddStatusToOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :status, :string, default: 'open'
  end
end
