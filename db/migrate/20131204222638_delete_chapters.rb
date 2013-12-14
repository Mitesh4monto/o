class DeleteChapters < ActiveRecord::Migration
  def change
    remove_column :strategies, :current_chapter_id
    drop_table :chapters
  end
end
