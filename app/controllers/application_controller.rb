class ApplicationController < ActionController::Base
  prepend_before_action :set_auth
  before_action :check_user

  before_action :get_comps

  private

  def set_auth
    p ENV["AUTH_ENABLED"]
    unless session[:user_token].present?
      unless request.format.json?
        session[:return_to] = request.original_fullpath
      end
      return render 'layouts/login', layout: 'layouts/login'
    end

    @user = User.find_by(email: session[:user_email])
  end

  def check_user
    unless @user.present?
      return redirect_to '/users/new'
    end

    if @user.user_phone_opt_in.nil? && @user.user_phone.nil?
      flash[:alert] = "Please update your phone number or click 'Update User' to opt out of text messages."
      redirect_to edit_user_path(@user)
    end
  end

  def get_comps
    @competitions = Competition.all
  end
end
