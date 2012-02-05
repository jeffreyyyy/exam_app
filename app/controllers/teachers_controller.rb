class TeachersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_teacher, :only => [:edit, :update]

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
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = "Profile Updated."
      redirect_to @teacher
    else
      render 'edit'
    end
  end
  
  def destroy
  end

  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_teacher
      @teacher = Teacher.find(params[:id])
      redirect_to(root_path) unless current_teacher?(@teacher)
    end
end
