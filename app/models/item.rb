class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :assembly_items
  has_many :assemblies, through: :assembly_items
end
