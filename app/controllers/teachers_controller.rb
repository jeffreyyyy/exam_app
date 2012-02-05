class TeachersController < ApplicationController

  def index
  end
  
  def new
    @teacher = Teacher.new
  end
  
  def show
    @teacher = Teacher.find(params[:id])
  end
  
  def edit
  end
  
  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      sign_in @teacher
      flash[:success] = "Welcome to the ExamApp!"
      redirect_to @teacher
    else
      render 'new'
    end
  end
  
  def update
  end
  
  def destroy
  end

end
