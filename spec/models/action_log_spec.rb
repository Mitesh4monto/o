require 'spec_helper'

describe ActionLog do
  it "has a valid factory" do 
    FactoryGirl.create(:action_log).should be_valid 
  end
  
  it "has a user" do
    al = FactoryGirl.create(:action_log)
    al.user.should be_valid
  end

  it "can find the most recent actions for a user" do
    hal = FactoryGirl.create(:hal)
    hal.user.action_logs.loggable.include?(hal).should be_true
  end

  it "can find the most recent actions for a list of users" do
  end


end
