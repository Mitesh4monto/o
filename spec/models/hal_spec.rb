require 'spec_helper'
require 'debugger'

describe Hal do
  it "has a valid factory" do 
    FactoryGirl.create(:hal).should be_valid 
  end
  
  it "returns a list of hals for an entry" do
    hal = FactoryGirl.create(:activity_hal)
    activity = FactoryGirl.create(:activity)
    hal.hal_about(activity)
    activity.hals.should include(hal)
  end
  
  it "can be created for activities" do
    hal = FactoryGirl.create(:activity_hal)
    activity = FactoryGirl.create(:activity)
    hal.hal_about(activity)
    hal.halable_type.should eq("Activity")
  end

  it "can find related hals" do
    act = FactoryGirl.create(:activity)
    hal1 = Hal.create(:entry => "fss")
    hal1.hal_about(act)
    
    a = FactoryGirl.create(:from_template_activity)

    user1 = FactoryGirl.create(:user)
    actcopy = a.copy_to_user(user1)
    hal = Hal.create(:entry => "another", :user_id => user1.id)
    hal.hal_about(actcopy)
    
    user = FactoryGirl.create(:user)
    b = a.copy_to_user(user)
    hal1 = Hal.create(:entry => "bbbbb", :user_id => user.id)
    hal1.hal_about(b)
#debugger    
    Hal.get_related_hals(b).should include(hal)
    Hal.get_related_hals(b).should_not include(hal1)
  end

  
  it "can find all hals in a course" do
    c = FactoryGirl.create(:course)
    a = FactoryGirl.create(:from_template_activity, :strategy_id => c.strategy.id, :course_id => c.id)

    user1 = FactoryGirl.create(:user)
    actcopy = a.copy_to_user(user1)
    hal = Hal.create(:entry => "another", :user_id => user1.id)
    hal.hal_about(actcopy)
    
    user = FactoryGirl.create(:user)
    b = a.copy_to_user(user)
    hal1 = Hal.create(:entry => "bbbbb", :user_id => user.id)
    hal1.hal_about(b)
    
    c.hals.should include(hal)
    c.hals.should include(hal1)
    
  end
  
end
