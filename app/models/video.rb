class Video < ApplicationRecord
  belongs_to :course

  validates :title, presence: true

  has_one_attached :file

  after_create_commit :set_duration
  after_update_commit :set_duration

  private

  def set_duration
    return unless file.attached?

    temp_file_path = Rails.root.join('tmp', file.filename.to_s)

    File.open(temp_file_path, 'wb') do |f|
      f.write(file.download)
    end

    movie = FFMPEG::Movie.new(temp_file_path.to_s)

    duration = movie.duration

    if duration.blank?
      Rails.logger.error("Failed to extract duration from video")
    else
      update_column(:duration, duration.to_f)
      course.update_total_duration
    end

    File.delete(temp_file_path) if File.exist?(temp_file_path)
  end
end
