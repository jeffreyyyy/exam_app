require 'spec_helper'

describe Teacher do
  
  before(:each) do
    @attr = { :name => "Luke Skywalker", :email => "luke@jediacademy.com" }
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
  
end
