class Course < ApplicationRecord
  has_many :videos, dependent: :destroy

  validates :title, :description, :start_date, :end_date, presence: true

  def total_video_size
    videos.sum(:size)
  end
end
