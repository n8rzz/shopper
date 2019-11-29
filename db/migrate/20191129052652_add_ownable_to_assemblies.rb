class AddOwnableToAssemblies < ActiveRecord::Migration[6.0]
  def change
    add_reference :assemblies, :ownable, polymorphic: true
  end
end
