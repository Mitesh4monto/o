class ChangeStringsToText < ActiveRecord::Migration
  def up
     change_column :activities, :title, :text
     change_column :activities, :timing_expression, :text
     change_column :activities, :customization, :text          
     change_column :courses, :name, :text
     change_column :courses, :external_site, :text     
     change_column :goals, :title, :text
     change_column :goals, :description, :text
  end

  def down
    change_column :activities, :title, :string
    change_column :activities, :timing_expression, :string
    change_column :activities, :customization, :string          
    change_column :courses, :name, :string
    change_column :courses, :external_site, :string     
    change_column :goals, :title, :string
    change_column :goals, :description, :string
  end
end
