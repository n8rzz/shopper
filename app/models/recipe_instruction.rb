# frozen_string_literal: true

# sort_order: integer
# text: string
# recipe: references
class RecipeInstruction < ApplicationRecord
  belongs_to :recipe

  validates :sort_order, presence: true
  validates_numericality_of :sort_order, greater_than_or_equal_to: 0
end
