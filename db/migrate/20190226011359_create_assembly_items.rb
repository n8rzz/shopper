class CreateAssemblyItems < ActiveRecord::Migration[6.0]
  def change
    create_table :assembly_items do |t|
      t.references :assembly, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
