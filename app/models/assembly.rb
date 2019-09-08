=begin

id:           integer
name:         string
created_at:   datetime
updated_at:   datetime

=end
class Assembly < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items
  has_many :items, through: :assembly_items
  has_many :meal_schedules, dependent: :destroy

  # TODO: this may be unused after `feature/34`
  scope :items, -> { AssemblyItem.where(assembly_id: self.ids).map { |assembly_item|
    assembly_item.item
  }}

  validates :name, presence: true, uniqueness: true

  def self.by_id
    Assembly.all.index_by(&:id)
  end
end
