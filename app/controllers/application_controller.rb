class ApplicationController < ActionController::Base
  prepend_before_action :set_auth

  before_action :get_comps

  private

  def set_auth
    p '!' * 100
    p ENV['AUTH_ENABLED']
    unless session[:user_token].present? || ENV['AUTH_ENABLED'] == 'false'
      session[:return_to] = request.original_fullpath
      render 'layouts/login', layout: 'layouts/login'
    end
    @user_name = session[:user_email] || "A Random Kraken"
  end

  def get_comps
    @competitions = Competition.all
  end
end
