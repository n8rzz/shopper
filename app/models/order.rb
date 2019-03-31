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

  def group_by_assembly_and_sort
    # FIXME: currently fails due to `nil` value keys from `group_by`
    self.order_items.group_by(&:assembly).sort_by { |k, v| k.name.to_s }
  end

  # TODO: shared method used in Item, should be abstracted
  def group_by_department
    self.order_items.group_by(&:department)
  end

  def group_by_department_and_sort
    self.group_by_department.sort_by { |k, v| k.name.to_s }
  end
end
