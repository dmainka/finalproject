class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,         only: [:destroy]

  def index
    if (signed_in? && current_user.admin)
      @users = User.all.paginate(page: params[:page], :per_page => 10)
    else
      if (!signed_in?)
        flash[:error] = "You must be signed in to view this page"
        redirect_to root_path
      else
        flash[:error] = "You are not authorized to view this page"
        redirect_to root_path
      end
    end
  end

  def show
    @user = User.find(params[:id])
    if (signed_in? && !current_user.admin && !current_user?(@user))
      flash[:error] = "You are not authorized to view this user!"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome(@user).deliver
      sign_in @user
      flash[:success] = "Welcome to Nile.com!  A welcome email has also been sent."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
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
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
