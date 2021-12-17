class Sprint < ApplicationRecord
  validates :name, presence: true

  belongs_to :project
  has_one :room
  has_many :tasks
end
