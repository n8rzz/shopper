class RemoveStatusFromOrderItem < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :status, :string
  end
end
