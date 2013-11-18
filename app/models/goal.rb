class Goal < ActiveRecord::Base
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :activities
  has_one :user
  
end
