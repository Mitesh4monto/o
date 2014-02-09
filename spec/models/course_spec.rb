require 'spec_helper'

describe Course do
  it "has a valid factory" do 
    FactoryGirl.create(:course).should be_valid 
  end
  
  it "has a strategy" do
      c = FactoryGirl.create(:course)
      c.course_strategy.should be_valid 
  end
  
  it "has a user" do
    c = FactoryGirl.create(:course)
    c.user.should be_valid
  end
  
  it "can be created from a strategy" do
    s = FactoryGirl.create(:strategy)
    c = Course.create_from_strategy(s)
    c.should be_valid
  end

  it "can add a user to itself" do
    c = FactoryGirl.create(:course)
    user = FactoryGirl.create(:user)
    usernumber_pre_add = c.users.size
    c.add_user_to_course(user)
    c.users.size.should eq usernumber_pre_add +1
    user.following_course_id.should eq c.id
  end

  it "can let you know if there are customization" do
    c = FactoryGirl.create(:course)
    a = FactoryGirl.create(:activity_no_assoc)
    c.strategy.current_activities
    
  end
end
