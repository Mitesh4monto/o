require 'spec_helper'

describe HalsController do

  describe "GET 'view_mine'" do
    it "returns http success" do
      get 'view_mine'
      response.should be_success
    end
  end

end
