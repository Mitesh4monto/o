class AddOverviewToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :overview, :text
  end
end
