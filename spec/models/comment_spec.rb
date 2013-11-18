require 'spec_helper'

describe Comment do
  it "has a valid factory" do 
    FactoryGirl.create(:comment).should be_valid 
  end
  
  it "has a user" do
    c = FactoryGirl.create(:comment)
    c.user.should be_valid
  end
  
  it "can retrieve all comments for a user" do
  end



end
