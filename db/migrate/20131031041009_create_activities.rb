class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :chapter_id
      t.string :title
      t.text :description
      t.integer :goal_id
      t.integer :from_template_activity_id

      t.timestamps
    end
  end
end
