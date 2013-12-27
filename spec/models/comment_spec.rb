require 'spec_helper'

describe Comment do
  it "has a valid factory" do 
    FactoryGirl.create(:comment).should be_valid 
  end
  
  it "has a user" do
    c = FactoryGirl.create(:comment)
    c.user.should be_valid
  end
  
  it "can be made about a hal" do
    hal = FactoryGirl.create(:activity_hal)
    c = Comment.create(:body => "fsdfsdfsdf")
    hal.add_comment(c)
    hal.comments.include?(c).should be_true
  end
  
  
  it "can retrieve all comments for a user" do
    u = FactoryGirl.create(:user)
    com_size = u.comments.size
    c = FactoryGirl.create(:comment)
    c.user = u
    c.save
    u = User.find u.id
    u.comments.size.should eq com_size +1
  end


end
