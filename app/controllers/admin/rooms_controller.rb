class Admin::RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    render plain: params[:room].inspect
  end
end
