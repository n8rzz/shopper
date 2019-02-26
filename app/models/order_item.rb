class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :assembly
end
