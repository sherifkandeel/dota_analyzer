class UsersController < ApplicationController
  before_action :logged_in_user
  def show
    @table_data = current_user.table_data 
  end
  
  def meta
    @table_data = merge Hero.table_data, current_user.table_data
  end

  private

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
