require 'spec_helper'

describe Hal do
  it "has a valid factory" do 
    FactoryGirl.create(:hal).should be_valid 
  end
  
  it "returns a list of hals for an entry" do
    hal = FactoryGirl.create(:activity_hal)
    activity = FactoryGirl.create(:activity)
    activity.hals.should include(hal)
  end
  
  it "can be created for activities" do
    hal = FactoryGirl.create(:activity_hal)
    hal.should be_valid 
    hal.halable_type should eq("Activity")
  end

  it "can be created for goals" do
  end

  it "can be created for chapters" do
  end

end
