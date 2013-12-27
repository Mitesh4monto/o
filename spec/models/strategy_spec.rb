require 'spec_helper'

describe Strategy do
  it "has a valid factory" do 
    FactoryGirl.create(:strategy).should be_valid 
  end
  
  it "has a user" do
    s = FactoryGirl.create(:user_strategy)
    s.user.should be_valid
  end
  
  it "can add an activity to a itself" do
    s = FactoryGirl.create(:strategy)
    a = Activity.create(:title => "ya", :description => "ddd")
    s.add_activity(a)
    s.activities.include?(a).should be_true
  end

  it "can delete an activity from a itself" do
    s = FactoryGirl.create(:strategy)
    a = FactoryGirl.create(:activity)
    s.add_activity(a)
    s.delete_activity(a)
    s.activities.include?(a).should be_false
  end
  
  it "can copy an activity to itself" do
    s = FactoryGirl.create(:strategy)
    a = FactoryGirl.create(:activity)
    a.description = "111"
    s.copy_activity_to_strategy(a)    
    found = false
    s.activities.each {|activity| if activity.description == "111" then found = true end}
    found.should be_true
  end
  
  it "can find out if an activity belongs to itself" do
    s = FactoryGirl.create(:strategy)
    a = Activity.create(:title => "ya", :description => "ddd")
    b = Activity.create(:title => "yaaa", :description => "dddeee")
    s.add_activity(a)
    s.activities.include?(a).should be_true
    s.activities.include?(b).should be_false
  end
  
end
