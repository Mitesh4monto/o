class CreateTimings < ActiveRecord::Migration
  def change
    create_table :timings do |t|
      t.integer :activity_id
      t.string :kind_of_timing
      t.string :info

      t.timestamps
    end
  end
end
