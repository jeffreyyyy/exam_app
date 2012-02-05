class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    teacher = Teacher.authenticate(params[:session][:email],
                                   params[:session][:password])
    if teacher.nil?
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    else
      sign_in teacher
      redirect_to teacher
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
