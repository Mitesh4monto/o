class AddCurrentChapterToStrategy < ActiveRecord::Migration
  def change
    add_column :strategies, :current_chapter, :integer
  end
end
