=begin

id:             integer
name:           string
created_at:     datetime
updated_at:     datetime
department_id:  integer

=end
class Item < ApplicationRecord
  belongs_to :department
  belongs_to :ownable, polymorphic: true

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items
  has_many :meal_schedules, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :by_name, -> { order('name ASC') }

  def self.group_by_department
    all.group_by(&:department)
  end

  def self.group_by_department_and_sort
    group_by_department.sort_by { |k, v| k.name.to_s }
  end

  # TODO: use this in places where we create these maps in components
  def self.by_id
    Item.all.index_by(&:id)
  end
end
