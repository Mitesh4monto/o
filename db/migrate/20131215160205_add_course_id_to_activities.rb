class AddCourseIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :course_id, :integer
  end
end
