class RemoveMercuryImages < ActiveRecord::Migration
  def up
    drop_table :mercury_images
  end

  def down
    create_table :mercury_images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
