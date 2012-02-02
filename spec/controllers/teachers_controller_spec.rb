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
  
  describe "POST 'create'" do
    
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end
      
      it "should not create the teacher" do
        lambda do
          post :create, :teacher => @attr
        end.should_not change(Teacher, :count)
      end
      
      it "should render the 'new' page" do
        post :create, :teacher => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "Jeffrey", :email => "jeffreyj@example.com", 
                  :password => "foobar", :password_confirmation => "foobar" }
      end
      
      it "should create a teacher" do
        lambda do
          post :create, :teacher => @attr
        end.should change(Teacher, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :teacher => @attr
        response.should redirect_to(teacher_path(assigns(:teacher)))
      end
    end
  end
end










