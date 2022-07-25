class TagTask < ApplicationRecord
  belongs_to :tag
  belongs_to :task

  before_validation :valid_tag_add_task

  private

  def valid_tag_add_task
    if tag_included? || tag_limit?
      errors.add(:tag_name, "It is not possible to add such a tag")
    end
  end

  def tag_limit?
    self.task.tags.count >= 3
  end

  def tag_included?
    self.task.tags.map(&:name).include?(self.tag.name)
  end
end
