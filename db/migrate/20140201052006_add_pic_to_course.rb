class AddPicToCourse < ActiveRecord::Migration
    def self.up
      add_attachment :courses, :course_image
      add_column :courses, :external_site, :string
    end

    def self.down
      remove_attachment :courses, :course_image
      remove_column :courses, :external_site
    end
end
