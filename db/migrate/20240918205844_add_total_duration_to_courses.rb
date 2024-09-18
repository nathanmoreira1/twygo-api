class AddTotalDurationToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :total_duration, :integer, default: 0
  end
end
