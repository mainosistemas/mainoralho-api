class UserVotesController < ApplicationController
  before_action :set_sprint, only: %i[index create]

  def index
    paginate json: @task.votes
  end

  def create
    @vote = current_user.votes.new(vote_params)
    @vote.task = @task

    if @vote.save
      ActionCable.server.broadcast("sprint_channel#{@task.sprint_id}", { message: current_user.id, type: "vote" })

      render json: @vote, status: :created
    else
      render json: @vote.errors.full_messages, status: :unprocessable_entity
    end
  end

  def vote_params
    params.require(:vote).permit(:score, :voted_moment_time)
  end

  def set_sprint
    @task = Task.find(params[:task_id])
  end
end
