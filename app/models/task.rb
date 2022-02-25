class Task < ApplicationRecord
  validates :name, presence: true
  validates :status_votation, presence: true

  belongs_to :sprint
  belongs_to :owner, class_name: 'User'
  has_many :votes, class_name: 'UserVote', dependent: :restrict_with_error

  enum status_votation: { not_started: 0, started: 1, finished: 2 }, _default: :not_started
end
