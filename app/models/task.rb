class Task < ApplicationRecord
  validates :name, presence: true

  belongs_to :sprint
  has_many :votes, class_name: 'UserVote', dependent: :restrict_with_error
end