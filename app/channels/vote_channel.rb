class VoteChannel < ApplicationCable::Channel
  def subscribed
    # puts "parametros: #{params}"

    stream_from "sprint_channel_#{params[:room]}"
    puts "#{params}"

    user = User.find_by(email: params[:user][:email])

    ActionCable.server.broadcast("sprint_channel_23", { message: user, type: 'conectado' })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
