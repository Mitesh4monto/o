class AddFollowingCourseToUser < ActiveRecord::Migration
  def change
    add_column :users, :following_course_id, :integer    
  end
end
