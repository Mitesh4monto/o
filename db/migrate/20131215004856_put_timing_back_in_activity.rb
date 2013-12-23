class PutTimingBackInActivity < ActiveRecord::Migration
  def up
    drop_table :timings
    add_column :activities, :kind_of_timing, :string    
    add_column :activities, :timing_expression, :string    
    add_column :activities, :timing_duration, :string        
    add_column :activities, :strategy_id, :integer        
  end

  def down
    create_table :timings do |t|
      t.integer :activity_id
      t.string :kind_of_timing
      t.string :info

      t.timestamps
    end
    
    remove_column :activities, :strategy_id
    remove_column :activities, :kind_of_timing
    remove_column :activities, :timing_expression
    remove_column :activities, :timing_duration
  end
end
