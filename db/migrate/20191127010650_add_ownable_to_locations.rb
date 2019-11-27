class AddOwnableToLocations < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :ownable, polymorphic: true
  end
end
