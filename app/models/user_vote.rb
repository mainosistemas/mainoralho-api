class UserVote < ApplicationRecord
  validates :score, presence: true
  belongs_to :user, foreign_key: :owner_id
  belongs_to :task
  enum score: { one: 1, two: 2, three: 3, five: 5, eight: 8, interrogation: 4, coffee: 6 }
end
