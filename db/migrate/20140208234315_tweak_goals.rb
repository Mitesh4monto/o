class TweakGoals < ActiveRecord::Migration
  def change
    add_column :goals, :course_id, :integer
    add_column :goals, :strategy_id, :integer    
  end
end
