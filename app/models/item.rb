class Item < ApplicationRecord
  belongs_to :department

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :assembly_items, dependent: :destroy
  has_many :assemblies, through: :assembly_items

  validates :name, presence: true, uniqueness: true

  scope :by_name, -> { order('name ASC') }

  def group_by_department
    self.group_by(&:department)
  end

  def group_by_department_and_sort
    self.group_by_department.sort_by { |k, v| k.name.to_s }
  end
end
