class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :department, optional: true
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true

  scope :has_department, -> { where.not(department_id: nil) }
  scope :has_assembly, -> { where.not(assembly_id: nil) }
  scope :has_item, -> { where.not(item_id: nil) }
end
