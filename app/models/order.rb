class Order < ApplicationRecord
  belongs_to :location, optional: true

  has_many :order_items, dependent: :destroy
  has_many :assemblies, through: :order_items
  has_many :items, through: :assemblies

  validates :status, inclusion: {
    in: %w(pending active cancelled complete),
    message: "%{value} is not a valid status"
  }, presence: true
end
