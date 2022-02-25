class UserVote < ApplicationRecord
  validates :score, presence: true
  validates :voted_moment_time, presence: true
  validates :task, uniqueness: { scope: :user }

  enum score: { one: 1, two: 2, three: 3, five: 5, eight: 8, interrogation: 4, coffee: 6 }

  belongs_to :user, foreign_key: :owner_id
  belongs_to :task
end
