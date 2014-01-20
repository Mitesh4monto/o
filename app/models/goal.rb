class Goal < ActiveRecord::Base
  acts_as_paranoid
  include ActionLogging
  has_many :action_logs, :as => :loggable

  belongs_to :from, class_name: Goal, :foreign_key => 'from_id'
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :from_template_hals, :as => :halable #, :dependent => :destroy
  has_many :activities #, :as => :activityable, :dependent => :destroy 
  has_one :user
  
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
    self.activities.first.strategy
  end

  
  # add a hal to list of hals for activity
  def hal_about(hal)
    hal.fromable = self.get_hierarchical_from
    self.hals << hal
  end


end
