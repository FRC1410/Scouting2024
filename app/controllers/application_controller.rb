class ApplicationController < ActionController::Base
  prepend_before_action :set_auth

  private

  def set_auth
    unless session[:user_token].present?
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      redirect_to root_path
    end
    @user_name = session[:user_email]
  end
end
