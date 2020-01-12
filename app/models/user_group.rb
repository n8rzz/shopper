# frozen_string_literal: true

class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def self.add_user_to_invited_group(user)
    return if user.invitation_group_id.nil?

    user_group = UserGroup.new(
      group_id: user.invitation_group_id,
      user_id: user.id
    )
    user_group.save
  end
end
