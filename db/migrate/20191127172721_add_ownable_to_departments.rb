class AddOwnableToDepartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :departments, :ownable, polymorphic: true
  end
end
