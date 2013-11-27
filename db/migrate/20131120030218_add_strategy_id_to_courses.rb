class AddStrategyIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_strategy_id, :integer    
  end
end
