class CreateHals < ActiveRecord::Migration
  def change
    create_table :hals do |t|
      t.integer :halable_id
      t.string :halable_type
      t.text :entry
      t.boolean :help
      t.text :insights
      t.integer :user_id

      t.timestamps
    end
  end
end
