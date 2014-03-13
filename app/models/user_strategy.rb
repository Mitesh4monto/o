class UserStrategy < Strategy  
  belongs_to :user
  belongs_to :from, :foreign_key => 'from_id'

  def title
    self.user_id
  end
  
  def get_hierarchical_from
    if (self.from)
      self.from.course
    end
  end
  
  def get_course_id
    nil    
  end
  
  def course
    nil    
  end

  def text
    self.user.name + "'s Plan"    
  end
  
end
