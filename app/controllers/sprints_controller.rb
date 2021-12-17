class SprintsController < ApplicationController
  def index
    paginate json: current_user.sprints
  end

  def create
    if @sprint = current_user.sprint.create(sprint_attributes)
      render json: { data: { sprint: @sprint.as_json } }, status: :created
    else
      render json: { data: { errors: @sprint.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def sprint_attributes
    params.require(:sprint).permit(:name, :project_id)
  end
end
