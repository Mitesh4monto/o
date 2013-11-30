class ReorgHierarchy < ActiveRecord::Migration
  def change
    add_column :activities, :activityable_type, :string    
    add_column :activities, :activityable_id, :integer    

    add_column :goals, :goalable_type, :string    
    add_column :goals, :goalable_id, :integer    
    
    remove_column :activities, :chapter_id
    remove_column :activities, :goal_id
    remove_column :activities, :from_template_activity_id
  end
end
