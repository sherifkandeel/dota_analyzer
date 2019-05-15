class HerosController < ApplicationController

  def index
    @table_data = Hero.table_data
  end
end 