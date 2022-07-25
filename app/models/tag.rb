class Tag < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :user
  has_many :tag_tasks
  has_many :tasks, through: :tag_tasks

  before_validation :valid_name

  private

  def valid_name
    if Tag.where(user_id: current_user.id).map(&:name).include?(self.name)
      errors.add(:tag_name, "Already using the name")
    end
  end
end
