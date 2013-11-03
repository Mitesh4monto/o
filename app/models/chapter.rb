class Chapter < ActiveRecord::Base
  belongs_to :strategy
  has_many :activities, :dependent => :destroy 
  
  amoeba do
    enable
    prepend :title => "Copy of "
  end
  
  
end
