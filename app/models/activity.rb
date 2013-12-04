class Activity < ActiveRecord::Base
  require "StrategyElementMethods"
  
  acts_as_orderable
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :fromhals, :as => :halable #, :dependent => :destroy
  has_many :comments, :as => :commentable #, :dependent => :destroy
  belongs_to :activityable, :polymorphic => true  
  belongs_to :user
  
  has_one :timing

  
  attr_accessible :from_id, :user_id, :title, :description

  belongs_to :from, class_name: Activity, :foreign_key => 'from_id'
  has_many :copied_activities, class_name: Activity, :foreign_key => 'from_id'
  
  after_create :create_timing
  
  amoeba do
    enable
    nullify :user_id
    # nullify :chapter_id
    exclude_field :hals    
    exclude_field :comments
    exclude_field :copied_activities            
    prepend :title => "Copy of "
    # set from template as original's from, or directly to original
    customize(lambda { |original_activity,new_activity|
      if original_activity.from_id then
        new_activity.from_id = original_activity.from_id
      else 
        new_activity.from_id = original_activity.id
      end
    })
  end

  # get strategy this activity is part of
  def strategy
    self.activityable.strategy
  end

  # add a hal to list of hals for activity
  def hal_about(hal)
    hal.fromable = self.get_hierarchical_from
    self.hals << hal
  end

  # get "from" template for chapter if exists or parent
  def get_hierarchical_from
    if (self.from_id) then
      self.from
    else 
      if (self.activityable) then
        self.activityable.get_hierarchical_from
      end
    end
  end

  
  # returns all hals that have the same from template
  def get_related_hals
    if (self.from_id)
      Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.id = ? or (activities.from_id = ? and activities.id != ?)", self.from_id, self.from_id, self.id])
    else  
      return []
    end    
  end
  
  
  
  # After creation of activity add timing
  def create_timing
    self.timing = Timing.create()   #todo add default value ?  whenever?
  end
  
  def make_copy
    a = self.amoeba_dup
    a.save
    a
  end


  def print    
    puts "Activity  id: #{id}. title:" + self.title
    if (self.activityable_id)
      puts "#{self.activityable_type}: #{self.activityable.title}"
    end    
    puts "from_id: #{self.from_id}, timing: #{self.timing.print}"
    puts "Hals:"
    self.hals.each {|hal| hal.print}
  end

end
