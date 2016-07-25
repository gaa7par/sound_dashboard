class Admin::RecordersController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @recorder = @room.recorders.create(recorder_params)
    redirect_to admin_room_path(@room)
  end

  def destroy
    @room = Room.find(params[:room_id])
    @recorder = @room.recorders.find(params[:id])
    @recorder.destroy

    redirect_to admin_room_path(@room)
  end

  private
  def recorder_params
    params.require(:recorder).permit(:name)
  end
end
