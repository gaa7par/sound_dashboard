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

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to [:admin, @room]
    else
      render 'new'
    end
  end

  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)
      redirect_to [:admin, @room]
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end
