require 'spec_helper'

describe Teacher do
  
  before(:each) do
    @attr = { :name => "Luke Skywalker", 
              :email => "luke@jediacademy.com",
              :password => "lightsaber",
              :password_confirmation => "lightsaber" 
            }
  end
  
  it "should require a name" do
    no_name_teacher = Teacher.new(@attr.merge(:name => "" ))
    no_name_teacher.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_teacher = Teacher.new(@attr.merge(:email => "" ))
    no_email_teacher.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 66
    long_name_teacher = Teacher.new(@attr.merge(:name => long_name))
    long_name_teacher.should_not be_valid
  end
  
  it "should reject names that are too short" do
    short_name = "a" * 4
    short_name_teacher = Teacher.new(@attr.merge(:name => short_name))
    short_name_teacher.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Teacher.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Teacher.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Teacher.create!(@attr.merge(:email => upcased_email))
    teacher_with_duplicate_email = Teacher.new(@attr)
    teacher_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      Teacher.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end

    it "should require a matching password confirmation" do
      Teacher.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Teacher.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      Teacher.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do
    
    before(:each) do
      @teacher = Teacher.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @teacher.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @teacher.encrypted_password.should_not be_blank
    end
  end
  
end
