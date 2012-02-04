require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    describe "invalid signin" do
      
      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template(:new)
      end
    
    end
    describe "with valid email and password" do
      
      before(:each) do
        @teacher = Factory(:teacher)
        @attr = { :email => @teacher.email, :password => @teacher.password }
      end
      
      it "should sign the teacher in" do
        post :create, :session => @attr
        controller.current_teacher.should == @teacher
        controller.should be_signed_in
      end
      
      it "should redirect to the teachers show page" do
        post :create, :session => @attr
        response.should redirect_to(teacher_path(@teacher))
      end
      
    end
  end

end
