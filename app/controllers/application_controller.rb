# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :set_csrf_cookie

  def current_owner
    return current_user if current_user.groups.empty?

    current_user.groups.first
  end

  protected

  def after_invite_path_for(_current_inviter, resource)
    group_path(resource.invitation_group_id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:username, :email, :password, :password_confirmation, :current_password]
    )
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :invitation_group_id])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:email, :username])
  end

  def set_csrf_cookie
    cookies["X_CSRF_Token"] = form_authenticity_token
  end
end
