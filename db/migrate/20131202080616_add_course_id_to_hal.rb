class AddCourseIdToHal < ActiveRecord::Migration
  def change
    add_column :hals, :course_id, :integer
  end
end
