# frozen_string_literal: true

# schedule_date:  datetime
# purchased:      boolean
# item_id:        integer
# order_item_id:  integer
# assembly_id:    integer
# meal_time       string
class MealSchedule < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :assembly, optional: true
  belongs_to :order_item, optional: true
  belongs_to :ownable, polymorphic: true

  validates :schedule_date, presence: true
  validates :meal_time, inclusion: {
    in: %w[morning afternoon evening none],
    message: "%{value} is not a valid meal_time"
  }, presence: true
  validate :item_xor_assembly_reference

  private

  def item_xor_assembly_reference
    unless item.blank? ^ assembly.blank?
      errors[:base] << 'Specify an assembly_id or an item_id but not both'
    end
  end
end
