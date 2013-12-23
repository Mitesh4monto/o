class UserStrategy < Strategy  
  belongs_to :user
  belongs_to :from, :foreign_key => 'from_id'
  
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
  
  
end
