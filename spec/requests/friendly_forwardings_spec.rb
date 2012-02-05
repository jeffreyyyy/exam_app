require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after signin" do
    teacher = Factory(:teacher)
    visit edit_teacher_path(teacher)
    fill_in :email,    :with => teacher.email
    fill_in :password, :with => teacher.password
    click_button
    response.should render_template('teachers/edit')
  end
end
