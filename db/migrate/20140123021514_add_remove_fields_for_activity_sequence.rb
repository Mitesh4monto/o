class AddRemoveFieldsForActivitySequence < ActiveRecord::Migration
  def up
    add_column :activities, :type, :string
    add_column :activity_sequences, :from_id, :integer
    add_column :activities, :current_activity_id, :integer
    add_column :activities, :act_seq_order, :integer
    remove_column :activity_sequences, :goal_id
    remove_column :activity_sequences, :element_order
    remove_column :activities, :next_activity
    remove_column :activities, :element_order
  end

  def self.down
    remove_column :activities, :type
    remove_column :activity_sequences, :from_id
    remove_column :activities, :current_activity_id
    remove_column :activities, :act_seq_order, :integer
    add_column :activity_sequences, :goal_id, :integer
    add_column :activity_sequences, :element_order, :integer
    add_column :activities, :next_activity, :integer
    add_column :activities, :element_order, :integer
  end
end
