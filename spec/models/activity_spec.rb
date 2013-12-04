require 'spec_helper'

describe Activity do
  
  it "has a valid factory" do 
    FactoryGirl.create(:activity).should be_valid 
  end
  
  it "has a user" do
    a = FactoryGirl.create(:activity)
    a.user.should be_valid
  end
  
  it "can find all blog entries about itself" do
    a = FactoryGirl.create(:activity)
    h = FactoryGirl.create(:hal)
    hal_size_pre_add = a.hals.size
    a.hals << h
    a.hals.size.should eq hal_size_pre_add + 1
  end

  it "can duplicate an activity that's a template and ref that activity" do
    a = FactoryGirl.create(:template_activity)    
    b = a.make_copy
    b.from_id.should eq a.id
  end
  
  it "can duplicate another activity that's not a template and ref that activity or its template ref" do
    a = FactoryGirl.create(:from_template_activity)
    b = a.make_copy
    b.from_id.should eq a.from_id
    act1 = FactoryGirl.create(:activity)
    act_copy = act1.make_copy
    act_copy.from_id.should eq act1.id
  end

  it "has no template it was created from if it is a template" do
    a = FactoryGirl.create(:template_activity)    
    a.from_id.should be_nil
  end

  it "can find all blog entries about others using same template" do
    activity_user_1 = FactoryGirl.create(:from_template_activity)    
    activity_user_2 = activity_user_1.make_copy
    hal = FactoryGirl.create(:hal)    
    activity_user_1.hals << hal
    hal2 = FactoryGirl.create(:hal)    
    activity_user_2.hals << hal2
    activity_user_2.get_related_hals.include?(hal).should be_true
  end

  it "can be blogged about" do
    a = FactoryGirl.create(:activity)
    h = Hal.create(:user => a.user, :entry => "entry", :insights => "insights", :help => false)
    a.hal_about(h)
    a.hals.include?(h).should be_true
  end
  
  it "has a timing" do
    a = FactoryGirl.create(:activity)
    a.timing.should be_valid
  end

  it "can have a goal" do
    a = FactoryGirl.create(:activity)
    g = FactoryGirl.create(:goal)
    a.activityable = g
    a.save
    a.activityable_type.should eq "Goal"
    a.activityable.should be_valid
  end
  
  it "is part of a user strategy if it isn't a template" do
    a = FactoryGirl.create(:activity)
    0.should eq 1
  end

  it "can be commitment marked about" do
    0.should eq 1
  end
  
  it "can find commitment marks about it" do
    0.should eq 1
  end
  
  it "has a strategy it's part of" do
    a = FactoryGirl.create(:activity)
    a.strategy.should be_valid
  end
  
  
end
