require 'spec_helper'

describe PlanController do

  describe "GET 'mine'" do
    it "returns http success" do
      get 'mine'
      response.should be_success
    end
  end

end
