class HomeController < ApplicationController
  def index
    @date = params[:date] || 'today'
    @rooms = Room.all
  end
end
