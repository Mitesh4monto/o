require 'spec_helper'

describe ActionLog do
  it "has a valid factory" do 
    FactoryGirl.create(:action_log).should be_valid 
  end
  
  it "has a user" do
    al = FactoryGirl.create(:action_log)
    al.user.should be_valid
  end

  it "can find the most recent actions performed by a user" do
    hal = FactoryGirl.create(:hal)
    b = []
    hal.user.action_logs.each {|al| b << al.loggable}
    b.include?(hal).should be_true
  end

  it "can find the most recent actions for a user's following list" do
    hal = FactoryGirl.create(:hal)
    hal_user2 = FactoryGirl.create(:activity_hal_user2)
    user3 = FactoryGirl.create(:user3)
    user3.follow(hal.user)    
    
    b = []
    ActionLog.latest(user3).each {|al| b << al.loggable}
    b.include?(hal).should be_true
    b.include?(hal_user2).should be_false
    
  end

  it "can find the most recent changes to courses a user has activities in" do
    user3 = FactoryGirl.create(:user3)
    template_activity = FactoryGirl.create(:template_activity)
    user3.strategy.copy_activity_to_strategy(template_activity)
    puts user3.to_yaml
    puts "following " + user3.get_following_courses.join(",")

    user = FactoryGirl.create(:user)
    activity2 = Activity.create(:user_id => user.id, :title => "fsdf", :description => "dde", :course_id => template_activity.course_id)
    template_activity.strategy.add_activity(activity2)
    puts template_activity.to_yaml
    puts "number 2:  #{activity2.to_yaml}"

    b = []
    ActionLog.latest(user3).each {|al| b << al.loggable}
    b.include?(activity2).should be_true
  end

end
