class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    static_pages_after_signup_path
  end

  def after_sign_up_path_for(resource)
    static_pages_after_signup_path
  end
end
