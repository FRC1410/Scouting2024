class ApplicationController < ActionController::Base
  prepend_before_action :set_auth
  before_action :check_user

  before_action :get_comps

  private

  def set_auth
    unless session[:user_token].present? || ENV['AUTH_ENABLED'] == 'false'
      session[:return_to] = request.original_fullpath
      render 'layouts/login', layout: 'layouts/login'
    end

    @user = if ENV['AUTH_ENABLED'] == 'false'
              User.first
            else
              User.find_by(email: session[:user_email])
            end
  end

  def check_user
    unless @user.present?
      redirect_to '/users/new'
    end
  end

  def get_comps
    @competitions = Competition.all
  end
end
