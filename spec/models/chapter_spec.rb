require 'spec_helper'

describe Chapter do
  it "has a valid factory" do
    FactoryGirl.create(:chapter).should be_valid 
  end

  it "can remove activities from itself" do
    mc = FactoryGirl.create(:chapter)
    activity = FactoryGirl.create(:chapterless_activity)
    mc.add_activity(activity)
    mc.get_activities.include?(activity).should  be_true
    mc.delete_activity(activity)
    mc.get_activities.include?(activity).should  be_false
  end

  it "can add activities to itself" do    
    mc = FactoryGirl.create(:chapter)
    activity = FactoryGirl.create(:chapterless_activity)
    mc.add_activity(activity)
    mc.get_activities.include?(activity).should  be_true
  end
  
  it "can be blogged about" do
    mc = FactoryGirl.create(:chapter)
    user = FactoryGirl.create(:user)    
    h = Hal.create(:user => user, :entry => "entry", :insights => "insights", :help => false)
    mc.hal_about(h)
    mc.hals.include?(h).should  be_true
  end
  
  it "can find all blog entries about itself" do    
    mc = FactoryGirl.create(:chapter)
    halsize = mc.hals.size
    chapter_hal = FactoryGirl.create(:chapter_hal)
    mc.hal_about(chapter_hal)
    chapter_hal2 = FactoryGirl.create(:chapter_hal)
    mc.hal_about(chapter_hal2)
    mc.hals.size.should eq halsize + 2
  end
  
  it "can have a teamplate it was crated from" do
    mc = FactoryGirl.create(:chapter_template)    
    mc2 = mc.make_copy
    mc2.from_id.should eq mc.id
  end
  
  # it "can find all blog entries about others using same template" do
  # end  

  it "has no from template if was created from scratch" do
    mc = FactoryGirl.create(:chapter_template)    
    mc.from_id.should be_nil
  end

  it "can have activities" do
    mc = FactoryGirl.create(:chapter_template)    
    activity= FactoryGirl.create(:chapterless_activity)    
    mc.add_activity(activity)
    mc.get_activities.size.should be >= 1
  end

  it "can have goals" do
    c = FactoryGirl.create(:chapter)    
    goalsize = c.goals.size    
    g = FactoryGirl.create(:goal)    
    c.goals << g
    c.goals.size.should eq goalsize + 1
  end
  
  it "can duplicate a chapter that's a template and ref that chapter" do
      c = FactoryGirl.create(:chapter_template)    
      b = c.make_copy
      b.from_id.should eq c.id
  end

  it "has a strategy it's part of" do
    c = FactoryGirl.create(:chapter_template)    
    c.strategy.should be_valid
  end

  # it "can reorder activities" do 
  # end
  
#   main chapter specs

end
