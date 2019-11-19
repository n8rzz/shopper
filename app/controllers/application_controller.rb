class ApplicationController < ActionController::Base
  # TODO: this may need to move
  before_action :authenticate_user!
  after_action :set_csrf_cookie

  protected

    def set_csrf_cookie
      cookies["X_CSRF_Token"] = form_authenticity_token
    end
end
