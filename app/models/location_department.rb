=begin

id:             integer
sort_order:     integer
department_id:  integer
location_id:    integer
created_at:     datetime
updated_a:      datetime

=end
class LocationDepartment < ApplicationRecord
  belongs_to :location
  belongs_to :department

  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }

  def self.find_all_by_location_id(id)
    LocationDepartment.where(location_id: id).order('sort_order ASC')
  end

  def self.find_displaced_record_by_direction(direction, starting_sort_order, location_id)
    direction_modifier = direction == 'down' ? 1 : -1
    displaced_record_sort_order = starting_sort_order + (1 * direction_modifier)

    LocationDepartment.find_by(sort_order: displaced_record_sort_order, location_id: location_id)
  end

  def self.get_next_sort_order(location_id)
    department_with_highest_sort_order = LocationDepartment.find_all_by_location_id(location_id).max_by(&:sort_order)

    unless department_with_highest_sort_order != nil
      return 0
    end

    department_with_highest_sort_order['sort_order'] + 1
  end
end
