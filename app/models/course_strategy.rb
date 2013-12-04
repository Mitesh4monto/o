class CourseStrategy < Strategy  
  has_one :course
  belongs_to :course, class_name: Course, :foreign_key => 'course_id'
  
end
