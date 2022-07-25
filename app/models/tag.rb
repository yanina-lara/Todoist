class Tag < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :user
  has_many :tag_tasks
  has_many :tasks, through: :tag_tasks

  before_validation :valid_name

  private

  def valid_name
    if Tag.where(user_id: 1).map(&:name).include?(self.name)
      errors.add(:tag_name, "Ya esta utilizando ese nombre")
    end
  end
end
