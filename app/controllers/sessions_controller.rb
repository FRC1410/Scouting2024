class SessionsController < ApplicationController
  skip_before_action :set_auth
  def create
    auth = request.env['omniauth.auth']
    session[:user_token] = auth.credentials.token
    session[:user_email] = auth.info.email
    redirect_to session[:return_to] || root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end