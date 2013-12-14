class CreateActivitySequences < ActiveRecord::Migration
  def change
    create_table :activity_sequences do |t|
      t.integer :goal_id
      t.integer :current_activity_id
      t.integer :strategy_id

      t.timestamps
    end
    
    add_column :activities, :next_activity, :integer
    add_column :activities, :activity_sequence_id, :integer
    remove_column :goals, :goalable_type
    remove_column :goals, :goalable_id    
  end
end
