class Users::InvitationsController < Devise::InvitationsController
  # POST /resource/invitation
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    if resource.username != nil
      # FIXME: send mail and ask for permission to add
      User.invite_existing_user_to_group(resource, current_inviter)

      set_flash_message :notice, :invitee_exists, email: resource.email
      redirect_to group_path(resource.invitation_group_id)

      return
    end

    yield resource if block_given?

    return respond_with_navigational(resource) { render :new } if !resource_invited

    if is_flashing_format? && self.resource.invitation_sent_at
      set_flash_message :notice, :send_instructions, email: self.resource.email
    end

    respond_with resource, location: after_invite_path_for(current_inviter, resource)
  end

  # PUT /resource/invitation
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource

    yield resource if block_given?

    if !resource.errors.empty?
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit }

      return
    end

    UserGroupInvitationJob.perform_later(resource)

    set_flash_message :notice, :updated_not_active if is_flashing_format?
    respond_with resource, location: new_session_path(resource_name)
  end

  private

  def invite_resource
    user = User.find_by(email: invite_params[:email])

    return super if user.nil?

    User.set_invitation_group_id!(user, invite_params[:invitation_group_id])
    user
  end
end
