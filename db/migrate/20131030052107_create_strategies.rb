class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.string :title
      t.text :description
      t.integer :course_id
      t.integer :user_id, null: false
      t.boolean :is_template, default: false
      t.integer :current_chapter_id

      t.timestamps
    end
  end
end
