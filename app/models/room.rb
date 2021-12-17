class Room < ApplicationRecord
  validates :name, presence: true

  belongs_to :sprint
end
