class Course < ApplicationRecord
  has_many :videos, dependent: :destroy

  validates :title, :description, :start_date, :end_date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description"]
  end

  def update_total_duration
    self.total_duration = videos.sum(:duration)
    save!
  end
end
