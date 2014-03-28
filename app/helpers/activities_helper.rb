module ActivitiesHelper


  def get_activity_by_goal_or_course(activities)
    keys = activities.pluck('goal_id').uniq
    return_hash = Hash.new
    # no course, no goal activities
    return_hash[nil] = activities.find_all {|a| a if a.goal_id== nil and a.course_id == nil}
    # for other activities
    keys.each do |key|
      g = Goal.find_by_id key
      if (g)
        index = g.title
        index +=' - course: ' + g.course.name if g.course
        return_hash[index] = activities.find_all {|a| a['goal_id'] == key}
      else 
        # no goal, but course
        acts = activities.find_all {|a| a['goal_id'] == key}  # should be nil goal
        return_hash.merge!(acts.group_by {|act| 'course: ' + act.course.name if act.course })        
      end
    end
    return_hash
  end

  
  # organize activities in hash by => list of acts
  def get_activity_by_map(activities, by="goal_id")
    keys = activities.pluck(by).uniq
    return_hash = Hash.new
    keys.each do |key|
      g = Goal.find_by_id key
      return_hash[g] = activities.find_all {|a| a[by] == key}
    end
    return_hash
  end
  
  # return all goals in a specific strategy (nil ommitted)
  def get_goals_for_strategy(strategy)
    keys = strategy.activities.pluck('goal_id').uniq
    Goal.find(keys)
  end


  def get_goal_collection_for_course(course_id) 
    Goal.where(course_id: course_id).pluck(:title)
  end
  
end
