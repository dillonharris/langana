class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:mobile_number], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.first_name}!"
      redirect_to(url_after_signin(user))
      session[:intended_url] = nil
    elsif worker = Worker.authenticate(params[:mobile_number], params[:password])
      session[:worker_id] = worker.id
      flash[:notice] = "Welcome back, #{worker.first_name}!"
      redirect_to(url_after_signin(worker))
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:worker_id] = nil
    redirect_to root_url, notice: "You are signed out"
  end

  private

  def url_after_signin(user)
    if user.confirmed_at
      session[:intended_url] || user
    else
      confirm_user_path(user)
    end
  end
end
