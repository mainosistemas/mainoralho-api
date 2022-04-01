# frozen_string_literal: true

class UserVote < ApplicationRecord
  KEY = 'user_vote'
  STORE_LIMIT = 10

  after_create :publish_to_dashboard

  validates :score, presence: true
  validates :voted_moment_time, presence: true
  validates :task, uniqueness: { scope: :user }

  enum score: { one: 1, two: 2, three: 3, five: 5, eight: 8, interrogation: 4, coffee: 6 }

  belongs_to :user, foreign_key: :owner_id
  belongs_to :task

  def self.list(limit: STORE_LIMIT)
    $redis.lrange(KEY, 0, limit).map do |raw_user_vote|
      JSON.parse(raw_user_vote)
    end
  end

  def self.push(raw_user_vote)
    broadcast_to_datas JSON.parse(raw_user_vote)
    $redis.lpush(KEY, raw_user_vote)
    $redis.ltrim(KEY, 0, STORE_LIMIT - 1)
  end

  private

  def publish_to_dashboard
    Publisher.publish('user_votes', attributes)
  end

  def broadcast_to_datas(datas)
    ActionCable.server.broadcast 'datas', score: datas['score'], owner_id: datas['owner_id'], task_id: datas['task_id']
  end
end
