class AddShoppingDateToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :shopping_date, :datetime, default: Time.now
  end
end
