class WorkersController < ApplicationController

  before_action :require_signin, except: [:index, :edit, :update, :show, :new, :destroy, :create, :forgot_password, :send_reset_code, :reset_password, :new_password, :confirm, :verify_confirmation]
  before_action :require_correct_worker, only: [:edit, :show ,:update, :destroy]

  def index
    case params[:scope]
      when "gardening"
        @workers = Worker.gardening
      when "domestic"
        @workers = Worker.domestic
      when "nannying"
        @workers = Worker.nannying
      when "labour"
        @workers = Worker.labour
      when "painting"
        @workers = Worker.painting
      when "carpentry"
        @workers = Worker.carpentry
      when "building"
        @workers = Worker.building
      when "plumbing"
        @workers = Worker.plumbing
      when "electrical"
        @workers = Worker.electrical
      when "pet_care"
        @workers = Worker.pet_care
      when "home_care"
        @workers = Worker.home_care
      when "other"
        @workers = Worker.other
      else
        @workers = Worker.confirmed
    end
  end

  def show
    @worker = Worker.find(params[:id])
    redirect_to(confirm_worker_path(current_user)) unless current_user.confirmed_at or current_worker?(@worker)
  end

  def new
    @worker = Worker.new
    @worker.role = 'worker'
    @worker.city = 'Cape Town'
    @worker.country = 'South Africa'
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      session[:worker_id] = @worker.id
      ConfirmationCode.generate(@worker)
      redirect_to confirm_worker_path(@worker), notice: "Thanks for signing up! Please enter the confirmation code sent to your mobile phone"
    else
      flash[:danger] = "Sorry, Your account could not be created"
      render :new
    end
  end

  def confirm
    @worker = Worker.find(params[:id])
  end

  def verify_confirmation
    @worker = Worker.find(params[:id])
    submitted_code = params[:worker][:mobile_confirmation_code]
    @worker.confirmation_attempts += 1
    @worker.save
    if @worker.confirmation_attempts > 9
      redirect_to confirm_worker_path(@worker), alert: "You have typed in the wrong code too many times, please try again tomorrow"
    elsif BCrypt::Engine.hash_secret(submitted_code, @worker.mobile_code_salt) == @worker.mobile_confirmation_code_digest
      @worker.confirmed_at = Time.now
      @worker.save
      redirect_to @worker, notice: "Thanks for confirming your mobile number!"
    else
      redirect_to confirm_worker_path(@worker), alert: "Incorrect confirmation code"
    end
  end

  def update
    if @worker.update(worker_params)
      redirect_to @worker, notice: "Account successfully updated!"
    else 
      render :edit
    end
  end

  def destroy
    @worker.destroy
    session[:worker_id] = nil
    redirect_to root_url, alert: 'Account successfully deleted!'
  end

  private

  def worker_params
    params.require(:worker).permit(
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

  def require_correct_worker
    @worker = Worker.find(params[:id])
    redirect_to root_url unless current_worker?(@worker)
  end

end
