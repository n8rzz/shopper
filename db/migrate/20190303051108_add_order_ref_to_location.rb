class AddOrderRefToLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :location, foreign_key: true
  end
end
