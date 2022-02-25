class TasksController < ApplicationController
  before_action :set_task, only: :show

  def index
    return head :no_content if current_user.tasks.empty?

    paginate json: current_user.tasks, status: :ok
  end

  def show
    if @task
      render json: @task, status: :ok
    else
      head :no_content
    end
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find_by_id(params[:id])
  end
  
  def update
    if @task.update(task_params)
      render json: { data: { task: @task.as_json } }, status: :sucess
    else
      render json: { data: { errors: @task.errors.full_messages } }, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    render json: { data: { task: @task } }, include: [:sprint, { votes: { include: :user } }]
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :sprint_id, :status_votation, :start_votation_time, :finish_votation_time, :limit_votation_time)
  end

  def set_task() 
    @task = Task.find(params[:id])
  end
end
