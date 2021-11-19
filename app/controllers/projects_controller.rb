class ProjectsController < ApplicationController

  def index
    paginate json: current_user.projects
  end

  def create
    if @project = current_user.projects.create(project_attributes)
      render json: { data: { project: @project.as_json } }, status: :created
    else
      render json: { data: { errors: @project.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private

  def project_attributes
    params.require(:project).permit(:name)
  end
end
