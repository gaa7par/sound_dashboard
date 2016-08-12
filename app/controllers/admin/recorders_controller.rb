class Admin::RecordersController < ApplicationController
  before_action :get_room

  def create
    @recorder = @room.recorders.new(recorder_params)
    if @recorder.save
      redirect_to admin_room_path(@room), notice: 'Recorder created successfully'
    else
      @rooms = Room.all
      @recorders = @room.recorders.where.not(id: nil)
      render '/admin/rooms/show'
    end
  end

  def destroy
    @recorder = @room.recorders.find(params[:id])
    @recorder.destroy

    redirect_to admin_room_path(@room)
  end

  private

  def recorder_params
    params.require(:recorder).permit(:name, :position_x, :position_y)
  end

  def get_room
    @room = Room.find(params[:room_id])
  end
end
