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
  end
  
  def update
  end
  
  def destroy
  end

end
