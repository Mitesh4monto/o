require 'spec_helper'

describe ActivitySequence do
  
  it "has a valid factory" do 
    as = FactoryGirl.create(:activity_sequence_in_plan).should be_valid 
    as = FactoryGirl.create(:activity_sequence_in_course).should be_valid 
  end

  it "has a strategy it's part of" do 
    as = FactoryGirl.create(:activity_sequence)    
  end  
  
  it "has none or many activities in sequences" do 
  end
  
  it "has a current activity_in_sequence" do 
  end
  
  it "can set the current activity_in_sequence to another" do 
  end
  
  it "can have and find an activity_sequence it was copied from" do 
  end

  it "can list all activities_in_sequences in order" do 
  end
  
  it "can add an activities_in_sequence" do 
  end

  it "can delete an activities_in_sequence" do 
  end
  
  it "can reorder activities_in_sequences" do 
  end
  
end