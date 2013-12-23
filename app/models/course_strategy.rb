class CourseStrategy < Strategy  
  # b :course
  belongs_to :course  #, class_name: Course, :foreign_key => 'course_id'
  
  
  def get_hierarchical_from
    self.course
  end
  
  
end
