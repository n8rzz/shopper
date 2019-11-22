class RemoveUserIdFromGroups < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :user_id
  end
end
