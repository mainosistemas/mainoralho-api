class RoomsController < ApplicationController

  def index
    paginate json: current_user.rooms
  end

  def create
    @room = current_user.rooms.new(room_attributes)
    if @room.save
      render json: { data: { room: @room.as_json } }, status: :created
    else
      render json: { data: { errors: @room.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def room_attributes
    params.require(:room).permit(:name, :sprint_id)
  end
end
