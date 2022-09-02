class VoteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sprint_channel_#{room.number}"

    puts("Parametros: #{params}")

    room.users << user unless room.users.include?(user)

    ActionCable.server.broadcast("sprint_channel_#{room.number}", { message: user, type: 'conectado', users: room.users})
  end

  def unsubscribed
    user = User.find_by(email: params[:user][:email])
    room.users.delete(user)
    ActionCable.server.broadcast("sprint_channel_#{room.number}", { message: user, type: 'desconectado' })
  end

  def iniciar_votacao(arg)
    task = Task.find(arg['task_id'])
    puts "Iniciando votação uhull #{params}"
    ActionCable.server.broadcast("sprint_channel_#{room.number}", { message: task, type: 'iniciar_votacao' })
  end

  def encerrar_votacao(arg)
    task = Task.find(arg['task_id'])
    puts "Encerrar votação uhull #{params}"
    ActionCable.server.broadcast("sprint_channel_#{room.number}", { message: task, type: 'encerrar_votacao' })
  end

  def votar(arg)
    puts "Vota #{arg}"
    puts "Votando uhull #{params}"
    ActionCable.server.broadcast("sprint_channel_#{room.number}", { message: arg['user_id'], type: 'votar' })
  end

  private

  def user
    @user ||= User.find_by(email: params[:user][:email])
  end

  def room
    @room ||= Room.find_or_create_by!(sprint: Sprint.find(params[:room]))
  end
end
