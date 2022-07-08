class VoteChannel < ApplicationCable::Channel
  def subscribed
    puts "parametros: #{params[:room]}"

    stream_from "sprint_channel_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def votar(data)
    msg = Message.new(content: data['message'])
    msg.save_message(params[:room])
  end
end
