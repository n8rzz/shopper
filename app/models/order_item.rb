# frozen_string_literal: true

# id:             integer
# order_id:       integer
# item_id:        integer
# assembly_id:    integer
# created_at:     datetime
# updated_at:     datetime
# department_id:  integer
# picked:         boolean
# qty:            integer
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :department, optional: true
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true

  has_many :meal_schedules

  scope :has_department, -> { where.not(department_id: nil) }
  scope :has_assembly, -> { where.not(assembly_id: nil) }
  scope :has_item, -> { where.not(item_id: nil) }

  def list_item_classnames
    base_classnames = "orderItem js-orderItem-#{id}"

    return base_classnames unless picked

    "#{base_classnames} mix-orderItem_isPicked"
  end

  def duplicate(order_id)
    OrderItem.new(
      order_id: order_id,
      assembly_id: assembly_id,
      item_id: item_id,
      picked: false,
      department_id: department_id,
      qty: qty
    )
  end

  def assembly_name_or_null
    return '' if assembly_id.nil?

    assembly.name
  end
end
