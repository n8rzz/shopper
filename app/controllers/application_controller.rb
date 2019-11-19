class ApplicationController < ActionController::Base
  # TODO: this may need to move
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :set_csrf_cookie

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
    end

    def set_csrf_cookie
      cookies["X_CSRF_Token"] = form_authenticity_token
    end
end
