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
  validates :shopping_date, presence: true

  scope :active, -> { where(status: 'active') }
  scope :pending, -> { where(status: 'pending') }
  scope :finished, -> { where.not(status: ['active', 'pending']) }

  def month_name
    self.shopping_date.strftime("%B")
  end

  def zero_padded_day
    self.shopping_date.strftime("%d")
  end

  def order_date
    self.shopping_date.strftime("%b %m, %Y")
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
