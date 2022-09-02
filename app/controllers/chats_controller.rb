class ChatsController < ApplicationController
  def show
    @votes = UserVote.all
  end
end
