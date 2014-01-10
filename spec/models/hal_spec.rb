require 'spec_helper'

describe Hal do
  it "has a valid factory" do 
    FactoryGirl.create(:hal).should be_valid 
  end
  
  it "returns a list of hals for an entry" do
    hal = FactoryGirl.create(:activity_hal)
    activity = FactoryGirl.create(:activity)
    activity.hal_about(hal)
    activity.hals.should include(hal)
  end
  
  it "can be created for activities" do
    hal = FactoryGirl.create(:activity_hal)
    activity = FactoryGirl.create(:activity)
    activity.hal_about(hal)
    hal.halable_type.should eq("Activity")
  end

  it "can be created for goals" do
    # hal = FactoryGirl.create(:goal_hal)
    # goal = FactoryGirl.create(:goal)
    # goal.hal_about(hal)
    # hal.should be_valid 
    # hal.halable_type.should eq("Goal")
  end

  it "can find related hals" do
    act = FactoryGirl.create(:activity)
    hal1 = Hal.create(:entry => "fss")
    act.hal_about(hal1)
    a = FactoryGirl.create(:from_template_activity)
    hal = Hal.create(:entry => "fss")
    a.hal_about(hal)
    b = a.make_copy
    b.hal_about(Hal.create(:entry => "bbbbb"))
    
    Hal.get_related_hals(b).should include(hal)
    Hal.get_related_hals(b).should_not include(hal1)
  end

  
  it "can find froms direct" do
  end

  it "can find froms indirect" do
  end
  
  it "can find all hals in a course" do
  end
  
end
