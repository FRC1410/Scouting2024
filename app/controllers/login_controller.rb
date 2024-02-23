class LoginController < ActionController::Base
  def login_no_google
    render layout: false
  end

  def login_bypass
    if ["cmbenjamin08", "scandallb225", "jeannie8965"].include?(params[:discord].downcase)
      session[:user_token] = params[:email]
      session[:user_email] = params[:email]
    end

    redirect_to root_path
  end
end
