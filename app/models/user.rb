class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :projects, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :sprints, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :tasks, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :votes, class_name: 'UserVote', foreign_key: :owner_id, dependent: :restrict_with_error

  def sprints_by_project(project_id)
    project = self.projects&.find_by_id(project_id)
    return [] if project.nil?

    project.sprints
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
   end
   
   def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
   end
   
   def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
   end
   
   private
   
   def generate_token
    SecureRandom.hex(10)
   end
end
