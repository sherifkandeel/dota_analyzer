class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  #after_action  :user_matches, only: :create

  def create
    begin
      @user = User.from_omniauth request.env['omniauth.auth']
    rescue
      flash[:error] = "Can't authorize you..."
    else
      log_in(@user)
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

  private
  
  def user_matches
    if Dota.api.matches(player_id: current_user.uid, limit: 1).empty?
      flash[:danger] = "You either have no games this month or need to expose Your public games from dota 2 options"
    end
  end
end