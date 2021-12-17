class Sprint < ApplicationRecord
  validates :name, presence: true

  belongs_to :project
  has_one :room, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
