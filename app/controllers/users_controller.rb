class UsersController < ApplicationController
  before_action :require_signin, except: [:index, :new, :create, :forgot_password, :send_reset_code, :reset_password, :new_password]
  before_action :require_correct_user, only: [:edit, :update, :destroy, :confirm, :verify_confirmation]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to(confirm_user_path(current_user)) unless current_user.confirmed_at
  end

  def new
    @user = User.new(role: 'employer')
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ConfirmationCode.generate(@user)
      redirect_to confirm_user_path(@user), notice: 'Thanks for signing up! Please enter the confirmation code sent to your mobile phone'
    else
      flash[:alert] = 'User could not be created'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      flash[:alert] = 'Account could not be updated'
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: 'Account successfully deleted!'
  end

  def confirm
  end

  # TODO this can be extracted to the application controller to handle workers and employers
  # but first need to test this thoroughly on both sides before moving it
  def verify_confirmation
    submitted_code = params[:user][:mobile_confirmation_code]
    @user.confirmation_attempts += 1
    @user.save
    if @user.confirmation_attempts > 9
      redirect_to confirm_user_path(@user), alert: 'You have typed in the wrong code too many times, please try again tomorrow'
    elsif BCrypt::Engine.hash_secret(submitted_code, @user.mobile_code_salt) == @user.mobile_confirmation_code_digest
      @user.confirmed_at = Time.now
      @user.save
      redirect_to @user, notice: 'Thanks for confirming your mobile number!'
    else
      redirect_to confirm_user_path(@user), alert: 'Incorrect confirmation code'
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    if @user.confirmed_at
      redirect_to @user, notice: 'Your number is already confirmed'
    elsif @user.verification_codes_sent > 9
      redirect_to @user, alert: 'You have requested too many codes, please try again tomorrow'
    else
      @user.verification_codes_sent += 1
      @user.save
      ConfirmationCode.generate(@user)
      redirect_to confirm_user_path(@user), notice: 'We sent it again! Please enter the confirmation code sent to your mobile phone'
    end
  end

  def forgot_password
  end

  def send_reset_code
    if @user = User.find_by(mobile_number: ApplicationHelper.format_mobile(params[:mobile_number]))
      if @user.verification_codes_sent > 9
        redirect_to signin_path, alert: 'Too many attempts for today, please try again tomorrow'
      else
        @user.verification_codes_sent += 1
        @user.save
        ConfirmationCode.generate(@user)
        redirect_to new_password_user_path(@user)
      end
    else
      redirect_to forgot_password_path, alert: 'No account with that phone number'
    end
  end

  def new_password
    @user = User.find(params[:id])
  end

  def reset_password
    @user = User.find(params[:id])
    submitted_code = params[:user][:mobile_confirmation_code]
    @user.confirmation_attempts += 1
    @user.save
    if @user.confirmation_attempts > 9
      redirect_to forgot_password_path, alert: 'You have typed in the wrong code too many times, please try again tomorrow'
    elsif correct_confirmation_code?(submitted_code)
      @user.update(user_params)
      @user.mobile_confirmation_code_digest = ''
      @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Password reset successful!'
    else
      redirect_to new_password_user_path(@user), alert: 'Incorrect confirmation code'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :mobile_number,
      :email,
      :password,
      :password_confirmation,
      :profile_picture,
      :role,
      :service,
      :home_language,
      :id_or_passport_number,
      :country_of_citizenship,
      :first_language,
      :second_language,
      :third_language,
      :work_permit_status

    )
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def correct_confirmation_code?(submitted_code)
    BCrypt::Engine.hash_secret(submitted_code, @user.mobile_code_salt) == @user.mobile_confirmation_code_digest
  end
end
