class AddParanoiaToModels < ActiveRecord::Migration
  def change
    add_column :hals, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
    add_column :activity_sequences, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
  end
end
