class SessionsController < ApplicationController
  skip_before_action :set_auth, :check_user
  def create
    auth = request.env['omniauth.auth']
    session[:user_token] = auth.credentials.token
    session[:user_email] = auth.info.email
    redirect_to session[:return_to] || root_path
  end

  def destroy
    @user = nil
    session[:user_token] = nil
    session[:user_email] = nil

    reset_session
    redirect_to root_path
  end
end