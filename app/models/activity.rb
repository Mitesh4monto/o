class Activity < ActiveRecord::Base
  acts_as_orderable
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :comments, :as => :commentable #, :dependent => :destroy
  belongs_to :goal
  belongs_to :chapter

  has_one :timing
  
  after_create :create_timing
  
  amoeba do
    enable
    prepend :title => "Copy of "
  end

  # After creation of strategy add main chapter
  def create_timing
    self.timing = Timing.create()   #todo add default value ?  whenever?
  end
  
end
