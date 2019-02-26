class Assembly < ApplicationRecord
  has_many :assembly_items
  has_many :assemblies, through: :assembly_items
  has_many :items, through: :assembly_items

  scope :items, -> { AssemblyItem.where(assembly_id: self.ids).map { |assembly_item|
    assembly_item.item
  }}
end
