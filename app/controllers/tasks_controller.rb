class TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]
  before_action :set_sprint, only: :index

  def index
    #return head :no_content if current_user.tasks.empty?

    paginate json: @sprint.tasks, status: :ok
  end

  def show
    if @task
      if @task.finished?
        render json: @task, include: [:sprint, { votes: { include: :user } }], methods: [:trend_voted, :ja_votou_usuarios], status: :ok
      else
        render json: @task, include: :sprint, methods: :ja_votou_usuarios, status: :ok
      end
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

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      render json: "deletado com sucesso"
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find_by_id(params[:id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :sprint_id, :status_votation, :start_votation_time, :finish_votation_time, :limit_votation_time)
  end
end
