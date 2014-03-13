class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,         only: [:destroy]

  def index
    if current_user.admin?
      @users = user.paginate(page: params[:page])
    else
      flash[:error] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  def show
    @user = user.find(params[:id])
    if (!current_user.admin? && !current_user?(@user))
      flash[:error] = "You are not authorized to view this user!"
      redirect_to root_path
    end
  end

  def new
    # @user = user.new
  end

  def create
    @user = user.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Nile.com!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = user.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user.find(params[:id]).destroy
    flash[:success] = "user deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = user.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
