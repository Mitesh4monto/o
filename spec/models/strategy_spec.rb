require 'spec_helper'

describe Strategy do
  it "has a valid factory" do 
    FactoryGirl.create(:strategy).should be_valid 
  end
  
  it "has a user" do
    s = FactoryGirl.create(:strategy)
    s.user.should be_valid
  end
  
  it "has a main chapter" do
    s = FactoryGirl.create(:strategy)     
    s.main_chapter.should be_valid
  end
  
  it "can be turned into a course strategy" do
    s = FactoryGirl.create(:strategy)     
    c = Course.create_from_strategy(s)
    c.should be_valid    
  end
  
end
