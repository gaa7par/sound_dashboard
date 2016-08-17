class Admin::RoomsController < ApplicationController
  before_action :authenticate_admin!

  expose :rooms, -> { Room.all }
  expose :room

  expose :recorders do
    room.recorders.where.not(id: nil)
  end
  expose :recorder

  def create
    if room.save
      redirect_to admin_room_path(room)
    else
      render :new
    end
  end

  def update
    if room.update(room_params)
      redirect_to admin_room_path(room)
    else
      render :edit
    end
  end

  def destroy
    room.destroy

    redirect_to admin_rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name, :dimension_x, :dimension_y)
  end
end
