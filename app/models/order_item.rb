class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true
end
