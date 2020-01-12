# frozen_string_literal: true

class UserGroupInvitationJob < ApplicationJob
  queue_as :urgent

  def perform(user)
    UserGroup.add_user_to_invited_group(user)
    User.remove_invitation_group_id_after_invitaion_acceptence(user)
  end
end
