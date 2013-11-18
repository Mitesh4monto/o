class AddFieldsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :description, :text
    add_column :courses, :about_the_author, :text
  end
end
