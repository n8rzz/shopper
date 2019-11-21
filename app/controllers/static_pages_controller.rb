class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :after_signup]

  def index
  end

  def after_signup
  end
end
