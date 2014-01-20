class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.integer :user_id
      t.string :action
      t.string :loggable_type
      t.integer :loggable_id
      t.string :link

      t.timestamps
    end
  end
end
