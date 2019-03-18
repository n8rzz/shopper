class Assembly < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items
  has_many :items, through: :assembly_items

  scope :items, -> { AssemblyItem.where(assembly_id: self.ids).map { |assembly_item|
    assembly_item.item
  }}

  validates :name, presence: true, uniqueness: true
  # validates :assembly_items, :length => { :minimum => 1 }
end
