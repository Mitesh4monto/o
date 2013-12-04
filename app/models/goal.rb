class Goal < ActiveRecord::Base
  include StrategyElementMethods

  belongs_to :from, class_name: Goal, :foreign_key => 'from_id'
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :fromhals, :as => :halable #, :dependent => :destroy
  has_many :activities, :as => :activityable, :dependent => :destroy 
  has_one :user
  belongs_to :goalable, :polymorphic => true
  
  amoeba do
    enable
    prepend :title => "Copy of "
    exclude_field :user_id
    # set from template as original's from, or directly to original
    customize(lambda { |original_goal,new_goal|
      if original_goal.from_id
        new_goal.from_id = original_goal.from_id
      else 
        new_goal.from_id = original_goal.id
      end
    })
  end

  
  def strategy
    self.goalable.strategy
  end

  # get "from" template for chapter if exists or parent
  def get_hierarchical_from
    if (self.from_id) then
      self.from
    else 
      if (self.goalable) then
        self.goalable.get_hierarchical_from
      end
    end
  end
  
  # add a hal to list of hals for activity
  def hal_about(hal)
    hal.fromable = self.get_hierarchical_from
    self.hals << hal
  end


end
