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
    s.should be_valid
<<<<<<< HEAD
    c = Course.create_course_from_strategy(s)
=======
    c = Course.create_from_strategy(s)
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39
    c.should be_valid    
  end
  
end
