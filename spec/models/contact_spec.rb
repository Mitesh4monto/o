require 'spec_helper'

describe Contact do
  it "has a valid factory" do 
    FactoryGirl.create(:contact).should be_valid 
  end
  it "returns a contact's full name as a string" do
     contact = FactoryGirl.create(:contact, firstname: "John", lastname: "Doe") 
     contact.name.should == "John Doe" 
  end
  it "is invalid without a firstname"
  it "is invalid without a lastname"
  it "returns a contact's full name as a string"
end


