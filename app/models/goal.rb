class Goal < ActiveRecord::Base
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :activities
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

end
