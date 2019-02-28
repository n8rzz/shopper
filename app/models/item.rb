class Item < ApplicationRecord
  belongs_to :department

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items

  validates :name, uniqueness: true
end
