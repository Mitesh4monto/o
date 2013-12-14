class AddSequenceOrderToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :position, :integer    
  end
end
