namespace :rabbitmq do
  desc 'Connect consumer to producer'
  task :setup do
    require 'bunny'

    connection = Bunny.new.tap(&:start)

    channel = connection.create_channel

    channel.queue('dashboard.user_votes', durable: true)
           .bind('crawler.user_votes')

    connection.close
  end
end
