# frozen_string_literal: true

# id:           integer
# name:         string
# created_at:   datetime
# updated_at:   datetime
class Department < ApplicationRecord
  belongs_to :ownable, polymorphic: true

  has_many :items, dependent: :nullify
  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items, dependent: :nullify
  has_many :location_departments, dependent: :nullify
  has_many :locations, through: :location_departments, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  scope :by_name, -> { order('name ASC') }
end
