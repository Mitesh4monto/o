class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :strategy_id
      t.string :title
      t.text :description
      t.integer :element_order, :default => 0, :null => false

      t.timestamps
    end
  end
end
