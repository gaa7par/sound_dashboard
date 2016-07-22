class Admin::RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    @room.save
    redirect_to [:admin, @room]
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end
