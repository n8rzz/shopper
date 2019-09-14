=begin

id:             integer
status:         string
created_at:     datetime
updated_at:     datetime
location_id:    datetime
shopping_date:  datetime

=end
class Order < ApplicationRecord
  belongs_to :location, optional: true

  has_many :assemblies, through: :order_items
  has_many :items, through: :assemblies
  has_many :departments, through: :order_items
  has_many :order_items, dependent: :destroy

  validates :status, inclusion: {
    in: %w(pending active cancelled complete),
    message: "%{value} is not a valid status"
  }, presence: true
  validates :shopping_date, presence: true

  scope :active, -> { where(status: 'active') }
  scope :pending, -> { where(status: 'pending') }
  scope :finished, -> { where.not(status: ['active', 'pending']) }

  # TODO: shared method used in Item, should be abstracted
  def group_by_department
    self.order_items.group_by(&:department)
  end

  def group_by_department_and_sort
    self.group_by_department.sort_by { |k, v| k.name.to_s }
  end

  def delete_assembly(id)
    order_items_to_remove = self.order_items.where(assembly_id: id)

    return nil if !self.live? || order_items_to_remove.size == 0

    order_items_to_remove.destroy_all
  end

  def duplicate
    return nil if Order.pending.count > 0

    duplicate_order = Order.new(status: 'pending', location_id: self.location_id, shopping_date: Time.now)
    duplicate_order.order_items << self.order_items.map { |order_item| order_item.duplicate(duplicate_order.id) }

    duplicate_order
  end

  def live?
    self.status == 'pending' || self.status == 'active'
  end

  def finished_by_shopping_date
    self.finished.order('shopping_date DESC')
  end
end
