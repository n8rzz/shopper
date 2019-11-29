class AddOwnableToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :ownable, polymorphic: true
  end
end
