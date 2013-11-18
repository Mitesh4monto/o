class AddOrderToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :element_order, :integer, :default => 0, :null => false
  end
end
