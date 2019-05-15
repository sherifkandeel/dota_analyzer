class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  
  def create
    begin
      @user = User.from_omniauth request.env['omniauth.auth']
    rescue
      flash[:error] = "Can't authorize you..."
    else
      log_in(@user)
      @user.get_matches
      flash[:success] = "Welcome, #{@user.nickname}!"
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      log_out if logged_in?
      flash[:success] = "Goodbye!"
    end
    redirect_to root_path
  end
end