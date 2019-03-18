class AddQtyToAssemblyItems < ActiveRecord::Migration[6.0]
  def change
    add_column :assembly_items, :qty, :integer, default: 1
  end
end
