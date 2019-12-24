class AddInvitationGroupTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invitation_group_token, :string
  end
end
