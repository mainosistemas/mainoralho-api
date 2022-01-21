class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :sprints, dependent: :restrict_with_error
  belongs_to :owner, class_name: "User"
end
