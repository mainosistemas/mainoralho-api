class RoomsController < ApplicationController

  def index
    paginate json: current_user.rooms
  end

  def create
    if @room = current_user.rooms.create(room_attributes)
      render json: { data: { project: @room.as_json } }, status: :created
    else
      render json: { data: { errors: @room.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def room_attributes
    params.require(:room).permit(:name, :project_id)
  end
end
