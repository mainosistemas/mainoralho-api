class UserVoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(vote, room)
    puts "sprint_channel_#{room}"
    ActionCable.server.broadcast "sprint_channel_#{room}", vote: render_message(vote), type: 'vote'
  end

  private

  def render_message(vote)
    ApplicationController.renderer.render(partial: 'votes/vote', locals: { vote: vote })
  end
end
