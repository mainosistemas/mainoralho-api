class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show destroy]

  def index
    return head :no_content if current_user.projects.empty?

    paginate json: current_user.projects.order(created_at: :desc), status: :ok
  end

  def show
    if @project
      render json: @project, status: :ok
    else
      head :no_content
    end
  end

  def destroy
    if @project.destroy
      render json: ["Project successfully deleted"], status: :ok
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  def create
    @project = current_user.projects.new(project_attributes)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = current_user.projects.find_by_id(params[:id])
  end

  def project_attributes
    params.require(:project).permit(:name)
  end
end
