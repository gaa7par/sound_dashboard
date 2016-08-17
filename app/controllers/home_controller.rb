class HomeController < ApplicationController
  expose :rooms, -> { Room.all }
  expose :date, -> { params[:date] || 'today' }

  def index
  end
end
