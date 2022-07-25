class TagTask < ApplicationRecord
  belongs_to :tag
  belongs_to :task

  before_validation :valid_tag_add_task

  private

  def valid_tag_add_task
    if tags_include? || tags_count?
      errors.add(:tag_name, "No se puede agregar dicha etiqueta")
    end
  end

  def tags_count?
    self.task.tags.count >= 3
  end

  def tags_include?
    self.task.tags.map(&:name).include?(self.tag.name)
  end
end
