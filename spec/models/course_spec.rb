require 'spec_helper'

describe Course do
  it "has a valid factory" do 
    FactoryGirl.create(:course).should be_valid 
  end
  
  it "has a strategy" do
      c = FactoryGirl.create(:course)
      c.strategy.should be_valid 
      c.strategy.activities.size.should eq 3
  end
  
  it "has a user" do
    c = FactoryGirl.create(:course)
    c.user.should be_valid
  end

  it "can be joined by a user" do
    c = FactoryGirl.create(:course)
    user = FactoryGirl.create(:user)
    actsize = user.strategy.activities.size    
    c.add_user_to_course(user)
    c.get_course_followers.include?(user).should be_true
    user.strategy.activities.size.should eq actsize + c.strategy.activities.size
  end

  it "can let you know if there are customization" do
    c = FactoryGirl.create(:course)
    a = FactoryGirl.create(:activity_no_assoc)    
    a.customization = "fdsfs"
    a.save
    c.add_activity a
    c.has_customizations?.should be_true

    c1 = FactoryGirl.create(:course)
    b = FactoryGirl.create(:activity_no_assoc)    
    b.customization = ""
    b.save
    c1.add_activity b
    c1.has_customizations?.should be_false    
  end
  
  it "can be searched" do
    c = FactoryGirl.create(:course, :name => "ignatius wonk")
    a = FactoryGirl.create(:activity_no_assoc, :title => "foo bar", :description => "a long set of words")
    c.add_activity a
    a = FactoryGirl.create(:activity_no_assoc, :title => "force becoming", :description => "completely different words")
    c.add_activity a
    
    course2 = FactoryGirl.create(:course, :name => "course number 2")
    a = FactoryGirl.create(:activity_no_assoc, :title => "my creative title", :description => "short")
    course2.add_activity a
    a = FactoryGirl.create(:activity_no_assoc, :title => "acting as activity", :description => "yaba words daba doo")
    course2.add_activity a
    
    Course.full_course_search("ignatius").include?(c).should be_true
    Course.full_course_search("ignatius").include?(course2).should be_false
    Course.full_course_search("xyzzyx").size.should eq 0
    Course.full_course_search("words").include?(course2).should be_true
    Course.full_course_search("words").include?(c).should be_true
    Course.full_course_search("word").include?(c).should be_true    
  end
  
end
