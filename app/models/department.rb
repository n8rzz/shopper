class Department < ApplicationRecord
  has_many :items, dependent: :nullify
  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items, dependent: :nullify

  validates :name, uniqueness: true
end
