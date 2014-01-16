class CourseStrategy < Strategy  
  acts_as_paranoid
  # b :course
  belongs_to :course  #, class_name: Course, :foreign_key => 'course_id'
  
  
  def get_hierarchical_from
    self.course
  end
  
  
end
