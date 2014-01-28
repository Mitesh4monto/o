require 'spec_helper'

describe ActivityInSequence do
  it "has a valid factory" do 
    FactoryGirl.create(:strategy).should be_valid 
  end
  
  it "has a user" do
    s = FactoryGirl.create(:user_strategy)
    s.user.should be_valid
  end
  
  it "has an activity sequence" do
  end
  
end
