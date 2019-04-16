class UpdateOrderShoppingDateDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :shopping_date, nil
  end
end
