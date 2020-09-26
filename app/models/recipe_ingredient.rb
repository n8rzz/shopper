# frozen_string_literal: true

# qty_value: string
# qty_unit: string
# name: string
# recipe: references
# item: references
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :item, optional: true

  validates :qty_unit, presence: true
  validates :qty_value, presence: true
  validate :name_xor_item_reference

  def name_xor_item_reference
    unless name.blank? ^ item.blank?
      errors[:base] << 'Specify an item_id or a Name but not both'
    end
  end
end
