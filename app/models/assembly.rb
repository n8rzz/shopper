# frozen_string_literal: true

# id:           integer
# name:         string
# created_at:   datetime
# updated_at:   datetime
class Assembly < ApplicationRecord
  belongs_to :ownable, polymorphic: true

  has_one :recipe, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items
  has_many :items, through: :assembly_items
  has_many :meal_schedules, dependent: :destroy

  # TODO: this may be unused after `feature/34`
  scope :items, lambda {
    AssemblyItem.where(assembly_id: ids).map(&:item)
  }

  validates :name, presence: true, uniqueness: true

  def self.by_id
    Assembly.all.index_by(&:id)
  end
end
