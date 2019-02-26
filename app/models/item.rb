class Item < ApplicationRecord
  has_many :assembly_items
  has_many :assemblies, through: :assembly_items
end
