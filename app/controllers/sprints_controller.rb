class SprintsController < ApplicationController
  before_action :set_sprint, only: :show
  before_action :sprints_by_project, only: :index

  def index
    return head :no_content if @sprints.empty?

    paginate json: @sprints.order(created_at: :desc), status: :ok
  end

  def show
    if @sprint
      render json: @sprint, status: :ok
    else
      head :no_content
    end
  end

  def create
    @sprint = current_user.sprints.new(sprint_attributes)
    if @sprint.save
      render json: @sprint, status: :created
    else
      render json: @sprint.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_sprint
    @sprint = Sprint.find_by_id(params[:id])
  end

  def sprint_attributes
    params.require(:sprint).permit(:name, :project_id)
  end

  def sprints_by_project
    @sprints = 
      if params[:project]
        current_user.sprints_by_project(params[:project])
      else
        current_user.sprints
      end
  end
end
