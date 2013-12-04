class ReorganizeStratCourseRel < ActiveRecord::Migration
  def change
    remove_column :courses, :course_strategy_id
    change_column :strategies, :user_id, :integer, :null => true
  end
end
