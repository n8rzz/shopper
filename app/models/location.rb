class Location < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def city_and_state
    "#{self.city}, #{self.state}"
  end
end
