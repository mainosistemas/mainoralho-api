class UserVotesController < ApplicationController
  def index
    paginate json: current_user.votes
  end

  def create
    @vote = current_user.votes.new(vote_params)
    if @vote.save
      render json: @vote, status: :created
    else
      render json: @vote.errors.full_messages, status: :unprocessable_entity
    end
  end

  def vote_params
    params.require(:vote).permit(:score, :task_id)
  end
end
