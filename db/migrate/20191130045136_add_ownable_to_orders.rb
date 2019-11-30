class AddOwnableToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :ownable, polymorphic: true
  end
end
