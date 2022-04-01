# frozen_string_literal: true

class Publisher
  class << self
    def publish(exchange, message = {})
      queue = channel.fanout("crawler.#{exchange}")
      queue.publish(message.to_json)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new.tap(&:start)
    end
  end
end
