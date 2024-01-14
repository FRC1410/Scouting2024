class ApplicationController < ActionController::Base
  prepend_before_action :set_auth, :get_comps

  private

  def set_auth
    unless session[:user_token].present?
      session[:return_to] = request.original_fullpath
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      render('layouts/login')
    end
    @user_name = session[:user_email]
  end

  def get_comps
    @competitions = Competition.all
  end
end
