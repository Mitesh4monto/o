class Chapter < ActiveRecord::Base
  belongs_to :strategy
  has_many :activities, :dependent => :destroy 
  
  amoeba do
    enable
    prepend :title => "Copy of "
  end

  def add_activity(activity)
    self.activities << activity
  end
  
  def delete_activity(activity)
    self.activities.destroy(activity)
  end
  
end
