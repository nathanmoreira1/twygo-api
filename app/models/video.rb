class Video < ApplicationRecord
  belongs_to :course

  validates :title, :url, :size, presence: true
end
