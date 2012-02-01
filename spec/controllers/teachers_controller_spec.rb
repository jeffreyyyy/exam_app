require 'spec_helper'

describe TeachersController do
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @teacher = Factory(:teacher)
    end
    
    it "should be successful" do
      get :show, id: @teacher
      response.should be_success
    end
    
    it "should find the correct teacher" do
      get :show, id: @teacher
      assigns(:teacher).should == @teacher
    end
  end

end
