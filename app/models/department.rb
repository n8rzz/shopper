class Department < ApplicationRecord
  has_many :items, dependent: :nullify

  validates :name, uniqueness: true
end
