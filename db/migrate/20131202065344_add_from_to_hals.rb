class AddFromToHals < ActiveRecord::Migration
  def change
    add_column :hals, :fromable_id, :integer
    add_column :hals, :fromable_type, :string
  end
end
