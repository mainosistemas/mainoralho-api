class VoteChannel < ApplicationCable::Channel
  def subscribed
    # puts "parametros: #{params}"

    room = params[:room]

    stream_from "sprint_channel_#{room}"
    puts "#{params}"

    user = User.find_by(email: params[:user][:email])
    # armazena cada usuario conectado
    # pegar usuarios da sessão
    # notifica todos na sala

    ActionCable.server.broadcast("sprint_channel_#{room}", { message: user, type: 'conectado', users: @users })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "Desconectar usuário #{params}"

    user = User.find_by(email: params[:user][:email])
    room = params[:room]

    ActionCable.server.broadcast("sprint_channel_#{room}", { message: user, type: 'desconectado' })
  end
end
