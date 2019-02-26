class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.references :assembly, foreign_key: true

      t.timestamps
    end
  end
end
