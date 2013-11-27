class AddTemplatingInfo < ActiveRecord::Migration
  def change
    add_column :chapters, :user_id, :integer    
    add_column :chapters, :from_id, :integer
    add_column :chapters, :active,  :boolean,  :default => true

    add_column :activities, :user_id, :integer    
    add_column :activities, :from_id, :integer
    add_column :activities, :active,  :boolean,  :default => true

    add_column :goals, :from_id, :integer
    add_column :goals, :active,  :boolean, :default => true
    
    add_column :strategies, :from_id, :integer
    add_column :strategies, :active,  :boolean,  :default => true
  end
  
end
