class UserVote < ApplicationRecord
  after_create :publish_to_dashboard

  validates :score, presence: true
  validates :task, uniqueness: { scope: :user }

  enum score: { one: 1, two: 2, three: 3, five: 5, eight: 8, interrogation: 4, coffee: 6 }

  belongs_to :user, foreign_key: :owner_id
  belongs_to :task

  private

  def publish_to_dashboard
    Publisher.publish('user_votes', attributes)
  end
end
