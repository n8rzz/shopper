class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :department, optional: true
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true

  scope :has_department, -> { where.not(department_id: nil) }
  scope :has_assembly, -> { where.not(assembly_id: nil) }
  scope :has_item, -> { where.not(item_id: nil) }

  def list_item_classnames
    base_classnames = "orderItem js-orderItem-#{self.id}"

    if self.picked
      base_classnames += " mix-orderItem_isPicked"
    end

    base_classnames
  end

  def duplicate(order_id)
    OrderItem.new(
      order_id: order_id,
      assembly_id: self.assembly_id,
      item_id: self.item_id,
      picked: false,
      department_id: self.department_id,
      qty: self.qty
    )
  end
end
