class UsersController < ApplicationController

  before_action :require_signin, except: [:index, :new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
#    @reviews_given = @user.reviews_given
#    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to confirm_user_path(@user), notice: "Thanks for signing up! Please enter the confirmation code sent to your mobile phone"
    else
      render :new
    end
  end

  def confirm
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: 'Account successfully deleted!'
  end

  private

  def user_params
    params.require(:user).
    permit(:first_name, :last_name, :mobile_number, :email, :password, :password_confirmation, :profile_picture)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
