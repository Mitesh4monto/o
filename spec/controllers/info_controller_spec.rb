require 'spec_helper'

describe InfoController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'eula'" do
    it "returns http success" do
      get 'eula'
      response.should be_success
    end
  end

end
