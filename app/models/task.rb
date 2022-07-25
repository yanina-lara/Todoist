class Task < ApplicationRecord
  validates :title, :status, presence: true
  validates :level, :inclusion => 0..5, numericality: { only_integer: true }
  enum status: [ :done, :to_do ]

  belongs_to :user
  has_many :tag_tasks
  has_many :tags, through: :tag_tasks

  scope :filter_status,            -> (status)             { where status: status }
  scope :filter_level,             -> (level)              { where level: level }
  scope :filter_created_at,        -> (created_at)         { where('created_at >= ?', created_at) }
  scope :filter_deadline,          -> (deadline)           { where('deadline <= ?', deadline) }
  scope :filter_tag,               -> (tag)                { joins(:tags).where("tags.id = ?", tag)}
  scope :order_deadline_level, -> { order('deadline DESC', created_at: :desc) }
end
