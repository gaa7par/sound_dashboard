class HomeController < ApplicationController
  expose :rooms, -> { Room.all }
  expose :date, -> { params[:date] || 'today' }
end
