# frozen_string_literal: true

# name: string
# description: string
# prep_time: integer
# cook_time: integer
# yield_value: string
# yield_unit: string
# ownable: references
# assembly: references
class Recipe < ApplicationRecord
  belongs_to :assembly, optional: true
  belongs_to :ownable, polymorphic: true

  has_many :recipe_ingredients
  has_many :recipe_instructions

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_instructions, allow_destroy: true

  validates :name, uniqueness: true
  validate :name_xor_assembly_reference

  def display_name
    return name if assembly.nil?

    assembly.name
  end

  private

  def name_xor_assembly_reference
    unless name.blank? ^ assembly.blank?
      errors[:base] << 'Specify an assembly_id or a Name but not both'
    end
  end
end
