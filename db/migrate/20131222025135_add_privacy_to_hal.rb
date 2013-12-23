class AddPrivacyToHal < ActiveRecord::Migration
  def change
    add_column :hals, :privacy, :integer        
  end
end
