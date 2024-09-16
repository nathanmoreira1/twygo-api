class Course < ApplicationRecord
  has_many :videos, dependent: :destroy

  validates :title, :description, :start_date, :end_date, presence: true
end
