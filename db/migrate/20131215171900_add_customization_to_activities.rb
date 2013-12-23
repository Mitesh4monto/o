class AddCustomizationToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :customization, :string
  end
end
