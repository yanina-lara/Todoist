class User < ApplicationRecord
  has_many :tag
  has_many :task
end
