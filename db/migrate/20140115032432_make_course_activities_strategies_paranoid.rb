class MakeCourseActivitiesStrategiesParanoid < ActiveRecord::Migration
  def up
    add_column :courses, :deleted_at, :datetime
    add_column :strategies, :deleted_at, :datetime
    add_column :activities, :deleted_at, :datetime
    add_column :goals, :deleted_at, :datetime
    
    remove_column :activities, :active
    remove_column :goals, :active
    remove_column :strategies, :active
  end

  def down
    remove_column :courses, :deleted_at
    remove_column :strategies, :deleted_at
    remove_column :activities, :deleted_at
    remove_column :goals, :deleted_at
    
    add_column :activities, :active,  :boolean,  :default => true
    add_column :goals, :active,  :boolean,  :default => true
    add_column :strategies, :active,  :boolean,  :default => true
  end
end
