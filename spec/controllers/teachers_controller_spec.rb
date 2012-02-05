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
  
  describe "GET 'edit'" do
    
    before(:each) do
      @teacher = Factory(:teacher)
      test_sign_in(@teacher)
    end
    
    it "should be successful" do
      get :edit, :id => @teacher
      response.should be_success
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
      
      it "should sign the teacher in" do
        post :create, :teacher => @attr
        controller.should be_signed_in
      end
    end
  end
  describe "PUT 'update'" do
    before(:each) do
      @teacher = Factory(:teacher)
      test_sign_in(@teacher)
    end

    describe "failure" do
      before(:each) do
        @attr = { :email => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end
      it "should render the 'edit' page" do
        put :update, :id => @teacher, :teacher => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
      end
      it "should change the teacher's attributes" do
        put :update, :id => @teacher, :teacher => @attr
        @teacher.reload
        @teacher.name.should  == @attr[:name]
        @teacher.email.should == @attr[:email]
      end
      it "should redirect to the teacher show page" do
        put :update, :id => @teacher, :teacher => @attr
        response.should redirect_to(teacher_path(@teacher))
      end
    end
  end
  describe "authentication of edit/update pages" do
    before(:each) do
      @teacher = Factory(:teacher)
    end
    
    describe "for non-signed-in teachers" do
      
      it "should deny access to 'edit'" do
        get :edit, :id => @teacher
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'update'" do
        put :update, :id => @teacher, :teacher => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "fot signed-in teachers" do
      
      before(:each) do
        wrong_teacher = Factory(:teacher, :email => 'user@example.net')
        test_sign_in(wrong_teacher)
      end
      
      it "should require matching teachers for 'edit'" do
        get :edit, :id => @teacher
        response.should redirect_to(root_path)
      end
      
      it "should require matching teachers for 'update'" do
        get :edit, :id => @teacher, :teacher => {}
        response.should redirect_to(root_path)
      end
    end
  end
end










