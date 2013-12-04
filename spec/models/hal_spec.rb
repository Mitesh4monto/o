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
    hal = FactoryGirl.create(:goal_hal)
    goal = FactoryGirl.create(:goal)
    goal.hal_about(hal)
    hal.should be_valid 
    hal.halable_type.should eq("Goal")
  end
  
  it "can be created for chapters" do
    hal = FactoryGirl.create(:chapter_hal)
    chapter = FactoryGirl.create(:chapter)
    chapter.hal_about(hal)
    hal.should be_valid 
    hal.halable_type.should eq("Chapter")
  end
  
  it "can find froms direct" do
  end

  it "can find froms indirect" do
  end
  
  it "can find all hals in a course" do
    
  end
  
end
