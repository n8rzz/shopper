class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :department, optional: true
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true

  validates :status, inclusion: {
    in: %w(open closed),
    message: "%{value} is not a valid status"
  }, presence: true

  def has_assembly?
    self.assembly_id != nil
  end

  def has_item?
    self.item_id != nil
  end
end
