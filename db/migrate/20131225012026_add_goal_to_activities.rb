class AddGoalToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :goal_id, :integer        
  end
end
