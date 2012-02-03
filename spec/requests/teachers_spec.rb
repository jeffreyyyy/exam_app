require 'spec_helper'

describe "Teachers" do
  describe "signup" do
    describe "failure" do
      it "should not make a new teacher" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ''
          fill_in "Email",        :with => ''
          fill_in "Password",     :with => ''
          fill_in "Confirmation", :with => ''
          click_button
          response.should render_template('teachers/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(Teacher, :count)
      end
    end
    describe "success" do
      it "should make a new teacher" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => 'Jeffrey'
          fill_in "Email",        :with => 'Jeffrey@example.com'
          fill_in "Password",     :with => 'Jeffrey'
          fill_in "Confirmation", :with => 'Jeffrey'
          click_button
          response.should render_template('teachers/show')
        end.should change(Teacher, :count).by(1)
      end
    end
  end
end
