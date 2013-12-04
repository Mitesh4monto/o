class UserStrategy < Strategy  
  belongs_to :user
  belongs_to :from, class_name: UserStrategy, :foreign_key => 'from_id'
  
end
