class AddFromIdToActivitySequence < ActiveRecord::Migration
  def change
    add_column :activity_sequences, :from_id, :integer    
    add_column :activity_sequences, :element_order, :integer, :default => 0, :null => false
  end
end
