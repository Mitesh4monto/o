class CreateOrderableThis < ActiveRecord::Migration
  def change
    create_table :orderable_this do |t|
      t.text :description
      t.integer :element_order, :default => 0, :null => false

      t.timestamps
    end
  end
end
