class Order < ApplicationRecord
  belongs_to :location, optional: true

  has_many :items, through: :assemblies
  has_many :order_items, dependent: :destroy
  has_many :assemblies, through: :order_items
  has_many :departments, through: :order_items

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

  def group_by_assembly
    self.order_items.group_by(&:assembly)
  end

  def group_by_department
    self.order_items.group_by(&:department)
  end

  def items_not_in_assemblies
    self.order_items.map { |order_item|
      return if order_item.assembly_id == nil
    }
  end

  def items_in_assemblies
    self.order_items.map { |order_item|
      return if order_item.assembly_id != nil && order_item.item_id != nil
    }
  end
end
