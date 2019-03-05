class Order < ApplicationRecord
  belongs_to :location, optional: true

  has_many :order_items, dependent: :destroy
  has_many :assemblies, through: :order_items
  has_many :items, through: :assemblies

  validates :status, inclusion: {
    in: %w(pending active cancelled complete),
    message: "%{value} is not a valid status"
  }, presence: true

  def month_name
    # move to future shopping_date column
    self.created_at.strftime("%B")
  end

  def zero_padded_day
    # move to future shopping_date column
    self.created_at.strftime("%d")
  end
end
