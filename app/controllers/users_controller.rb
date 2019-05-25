class UsersController < ApplicationController
  before_action :user_has_matches, :logged_in_user
  def show
    current_user.get_matches
    @table_data = current_user.table_data     
  end
  
  def meta
    current_user.get_matches
    @table_data = merge Hero.table_data, current_user.table_data
  end

  private

  def user_has_matches
    return unless current_user
    if Dota.api.matches(player_id: current_user.uid, limit: 1).empty?
      flash[:danger] = "You either have no games this month or need to expose Your public games from dota 2 options"
      redirect_to root_path
    end
  end
  
  def merge h1, h2
    h1[:headers_data].unshift(h2[:headers_data][1])
    h1[:headers_data].unshift(h2[:headers_data][0])
    h1[:totals][:your_pick] = h2[:totals][:your_pick]
    h2[:body_data].each do |k, v|
       h1[:body_data][k][:your_pick] = v[:your_pick]
       h1[:body_data][k][:your_win] = v[:your_win]
    end
    h1
  end
end
