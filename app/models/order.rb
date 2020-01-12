# frozen_string_literal: true

# id:             integer
# status:         string
# created_at:     datetime
# updated_at:     datetime
# location_id:    datetime
# shopping_date:  datetime
class Order < ApplicationRecord
  belongs_to :ownable, polymorphic: true
  belongs_to :location, optional: true

  has_many :assemblies, through: :order_items
  has_many :items, through: :assemblies
  has_many :departments, through: :order_items
  has_many :order_items, dependent: :destroy

  validates :status, inclusion: {
    in: %w[pending active cancelled complete],
    message: "%<value> is not a valid status"
  }, presence: true
  validates :shopping_date, presence: true

  scope :active, -> { where(status: 'active') }
  scope :pending, -> { where(status: 'pending') }
  scope :finished, -> { where.not(status: ['active', 'pending']) }

  # TODO: shared method used in Item, should be abstracted
  def group_by_department
    order_items.group_by(&:department)
  end

  def group_by_department_and_sort
    group_by_department.sort_by { |k| k.name.to_s }
  end

  def delete_assembly(id)
    order_items_to_remove = order_items.where(assembly_id: id)

    return nil unless live? || order_items_to_remove.empty?

    order_items_to_remove.destroy_all
  end

  # TODO: re-implement via: https://github.com/n8rzz/shopper/issues/314
  # def duplicate
  #   return nil if Order.pending.count.positive?

  #   duplicate_order = current_owner.orders.new(
  #     status: 'pending',
  #     location_id: location_id,
  #     shopping_date: Time.now
  #   )
  #   duplicate_order.order_items << order_items.map { |order_item| order_item.duplicate(duplicate_order.id) }

  #   duplicate_order
  # end

  def live?
    status == 'pending' || status == 'active'
  end

  def finished_by_shopping_date
    finished.order('shopping_date DESC')
  end
end
