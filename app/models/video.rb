class Video < ApplicationRecord
  belongs_to :course

  has_one_attached :file

  validates :title, presence: true
end
