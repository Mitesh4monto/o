class AddGoalTextToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :goal_text, :string
  end
end
