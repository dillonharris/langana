class UsersController < ApplicationController

  before_action :require_signin, except: [:index, :new, :create, :forgot_password, :send_reset_code, :reset_password]
  before_action :require_correct_user, only: [:edit, :update, :destroy, :confirm, :verify_confirmation]

  def index
    @users = User.workers.confirmed
  end

  def show
    @user = User.find(params[:id])
    redirect_to(confirm_user_path(current_user)) unless current_user.confirmed_at or current_user?(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ConfirmationToken.generate(@user)
      redirect_to confirm_user_path(@user), notice: "Thanks for signing up! Please enter the confirmation code sent to your mobile phone"
    else
      render :new
    end
  end

  def confirm
  end

  def verify_confirmation
    submitted_token = params[:user][:mobile_confirmation_token]
    @user.confirmation_attempts += 1
    @user.save
    if @user.confirmation_attempts > 9
      redirect_to confirm_user_path(@user), alert: "You have typed in the wrong code too many times, please try again tomorrow"
    elsif BCrypt::Engine.hash_secret(submitted_token, @user.mobile_token_salt) == @user.mobile_confirmation_token_digest
      @user.confirmed_at = Time.now
      @user.save
      redirect_to @user, notice: "Thanks for confirming your mobile number!"
    else
      redirect_to confirm_user_path(@user), alert: "Incorrect confirmation token"
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    if @user.confirmed_at
      redirect_to @user, notice: "Your number is already confirmed"
    elsif @user.verification_tokens_sent > 9
      redirect_to @user, alert: "You have requested too many codes, please try again tomorrow"
    else
      @user.verification_tokens_sent += 1
      @user.save
      ConfirmationToken.generate(@user)
      redirect_to confirm_user_path(@user), notice: "We sent it again! Please enter the confirmation code sent to your mobile phone"
    end
  end

  def forgot_password
  end

  def send_reset_code
    if @user = User.find_by(mobile_number: params[:mobile_number])
      redirect_to reset_password_user_path(@user)
    else
      redirect_to forgot_password_path, alert: "No account with that phone number"
    end
  end

  def reset_password
    @user = User.find(params[:id])
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
    permit(:first_name, :last_name, :mobile_number, :email, :password, :password_confirmation, :profile_picture, :role)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
