# frozen_string_literal: true

class ExistingUserGroupInviteMailer < ApplicationMailer
  default from: 'xrayshoppper@gmail.com'

  # TODO: rename this to just `.invite`
  def group_invite(user, _current_inviter)
    @user = user
    @url = build_group_invitation_url(user)

    mail(to: @user.email, subject: "You've been invited to a Group!")
  end

  private

  def build_group_invitation_url(user)
    "#{groups_invitation_url}?invitation_group_token=#{user.invitation_group_token}"
  end
end
