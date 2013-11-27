require 'spec_helper'

describe Chapter do
  it "has a valid factory" do
    FactoryGirl.create(:main_chapter).should be_valid 
    FactoryGirl.create(:chapter).should be_valid 
  end

  it "can remove activities from itself" do
    mc = FactoryGirl.create(:main_chapter)
    puts mc.get_activities.size
    activity = FactoryGirl.create(:chapterless_activity)
    mc.add_activity(activity)
    activity.print
    puts mc.get_activities.size
    mc.get_activities.include?(activity).should  be_true
    mc.delete_activity(activity)
    mc.get_activities.include?(activity).should  be_false
  end

  it "can add activities to itself" do    
    mc = FactoryGirl.create(:main_chapter)
    activity = FactoryGirl.create(:chapterless_activity)
    activity.print
    puts mc.get_activities.size
    mc.add_activity(activity)
    mc.get_activities.include?(activity).should  be_true
  end
  
  it "can be blogged about" do
    mc = FactoryGirl.create(:main_chapter)
    user = FactoryGirl.create(:user)    
    h = Hal.create(:user => user, :entry => "entry", :insights => "insights", :help => false)
    mc.hal_about(h)
    mc.hals.include?(h).should  be_true
  end
  
  it "can find all blog entries about itself" do    
    mc = FactoryGirl.create(:main_chapter)
    halsize = mc.hals.size
    chapter_hal = FactoryGirl.create(:chapter_hal)
    mc.hal_about(chapter_hal)
    chapter_hal2 = FactoryGirl.create(:chapter_hal)
    mc.hal_about(chapter_hal2)
    mc.hals.size.should eq halsize + 2
  end
  
  it "can have a teamplate it was crated from" do
    mc = FactoryGirl.create(:main_chapter_template)    
    mc2 = mc.make_copy
    mc2.from_id.should eq mc.id
  end
  
  it "can find all blog entries about others using same template" do
  end  

  it "has no from template if was created from scratch" do
  end

  it "can have activities" do
  end

  it "can have goals" do
  end
  
  it "is part of a user strategy if it isn't a template" do
  end

  it "can duplicate a chapter that's a template and ref that chapter" do
  end

  it "has a strategy it's part of" do
  end

  # it "can reorder activities" do 
  # end
  
#   main chapter specs

end
