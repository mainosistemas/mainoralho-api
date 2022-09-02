class Sprint < ApplicationRecord
  validates :name, presence: true

  belongs_to :project
  has_many :tasks, dependent: :destroy
  has_many :rooms, dependent: :destroy
  belongs_to :owner, class_name: "User"
end
