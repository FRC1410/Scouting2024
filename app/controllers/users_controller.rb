class UsersController < ApplicationController
  skip_before_action :check_user
  skip_before_action :set_auth, only: [:local_login]

  def show
  end

  def local_login
    if params[:user_email].present?
      session[:user_email] = params[:user_email]
      session[:user_token] = params[:user_email]
    else
      return render 'layouts/login', layout: 'layouts/login'
    end

    redirect_to root_path
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  def new
    @new_user = User.new
  end

  def create
    @user = User.new(user_params.merge(email: session[:user_email]))

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :initials, :user_phone, :user_phone_opt_in)
  end
end