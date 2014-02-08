module ActivitiesHelper
  
  # organize activities in hash by => list of acts
  def get_activity_by_map(activities, by="goal_text")
    keys = activities.pluck(by).uniq.sort.reverse  # TODO hack to have empty at end
    return_hash = Hash.new
    keys.each do |key|
      return_hash[key] = activities.find_all {|a| a[by] == key}
    end
    return_hash
  end
  
  
end
