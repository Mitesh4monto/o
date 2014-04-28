module ActivitiesHelper


  def get_activity_by_goal_or_course(activities, show_course = true)
    keys = activities.pluck('goal_id').uniq
    return_hash = Hash.new
    # if activities with no course, no goal
    return_hash[nil] = activities.find_all {|a| a if a.goal_id== nil and a.course_id == nil} if show_course
    return_hash[nil] = activities.find_all {|a| a if a.goal_id== nil } if !show_course
    # if no courseless goalless activities were found, remove nil key
    return_hash.delete_if{|k,v| k==nil and v==[]}
    
    # for other activities
    keys.each do |key|
      g = Goal.find_by_id key
      if (g)
        index = g.title
        index +=' - course: ' + g.course.name if g.course and show_course
        return_hash[index] = activities.find_all {|a| a['goal_id'] == key}
      else 
        # no goal, but course
        acts = activities.find_all {|a| a['goal_id'] == key}  # should be nil goal
        return_hash.merge!(acts.group_by {|act| 'course: ' + act.course.name if act.course and show_course })        
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
    if (keys != [nil])
      Goal.find(keys)
    else 
      # no goals
      []
    end
  end


  def get_goal_collection_for_course(course_id) 
    Goal.where(course_id: course_id).pluck(:title)
  end
  
  def timing_text(activity)
    return_text = ''
    case activity.kind_of_timing
    	when "Frequency"
      		if activity.timing_expression 
    			  return_text = activity.timing_expression.split.first +  " times per " + activity.timing_expression.split.last
      	  else 
      			return_text = "timing error"
    		 end
    	 when "One time"
    		 return_text = "Once"
    	 when "Other" 
    	 when "Whenever" 
    	 when "Reactive" 
    	   if activity.timing_expression
    		   return_text = "When " +  activity.timing_expression    
  		   else
  		     return_text = 'Reactive'
  		   end
    	 else 
    		 return_text = "error"
    end 
    if !activity.timing_duration.blank? and activity.course_activity? 
      return_text += "until "  + activity.timing_duration + "from join"
    elsif activity.timing_until 
      return_text = "before "  +  activity.timing_until.strftime("%m/%d/%Y") 
    end 
    return_text    
  end
  
end
