class UserVotesWorker
  include Sneakers::Worker

  from_queue 'dashboard.user_votes', env: nil

  def work(raw_user_vote)
    message

    UserVote.push(raw_user_vote)
    ack!
  end

  def message
    response = JSON.parse(msg)
    $redis.incr "processor:#{response['error']}" if response['type'] == 'error'
  end
end
