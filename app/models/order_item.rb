class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true

  def has_assembly?
    self.assembly_id != nil
  end

  def has_item?
    self.item_id != nil
  end
end
