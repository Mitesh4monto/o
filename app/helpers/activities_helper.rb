module ActivitiesHelper
  
  # organize activities in hash by => list of acts
  def get_activity_by_map(activities, by="goal_id")
    activities.inspect
    keys = activities.pluck(by).uniq
    return_hash = Hash.new
    keys.each do |key|
      g = Goal.find_by_id key
      return_hash[g] = activities.find_all {|a| a[by] == key}
    end
    return_hash
  end


  def get_goal_collection_for_course(course_id) 
    Goal.where(course_id: course_id).pluck(:title)
  end
  
end
