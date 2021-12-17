class TasksController < ApplicationController

  def index
    paginate json: current_user.tasks
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: { data: { task: @task.as_json } }, status: :created
    else
      render json: { data: { errors: @task.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  private 

  def task_params
    params.require(:task).permit(:name, :description, :sprint_id)
  end
end