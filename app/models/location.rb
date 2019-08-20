=begin

id:           integer
name:         string
city:         string
state:        string
created_at:   datetime
updated_a:    datetime

=end
class Location < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :location_departments, dependent: :nullify
  has_many :departments, through: :location_departments, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  scope :by_name, -> { order('name ASC') }

  def city_and_state
    "#{self.city}, #{self.state}"
  end
end
