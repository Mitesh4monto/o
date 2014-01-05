class RemoveColumnTitleFromStrategy < ActiveRecord::Migration
  def up
    remove_column :strategies, :title
  end

  def down
    add_column :strategies, :title, :string    
  end
end
