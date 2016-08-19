class Admin::RecordersController < ApplicationController
  expose(:room, id: :room_id)

  expose(:recorders) { room.recorders.where.not(id: nil) }
  expose(:recorder, attributes: :recorder_params, parent: :room)

  def create
    if recorder.save
      redirect_to admin_room_path(room), notice: 'Recorder created successfully'
    else
      render '/admin/rooms/show'
    end
  end

  def destroy
    recorder.destroy

    redirect_to admin_room_path(room)
  end

  private
  def recorder_params
    params.require(:recorder).permit(:name, :position_x, :position_y)
  end
end
