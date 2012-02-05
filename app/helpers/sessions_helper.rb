module SessionsHelper
  
  def sign_in(teacher)
    cookies.permanent.signed[:remember_token] = [teacher.id, teacher.salt]
    self.current_teacher = teacher
  end
  
  def current_teacher=(teacher)
    @current_teacher = teacher
  end
  
  def current_teacher
    @current_teacher ||= teacher_from_remember_token
  end
  
  def signed_in?
    !current_teacher.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_teacher = nil
  end
  
  def current_teacher?(teacher)
    teacher == current_teacher
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
  
    def teacher_from_remember_token
      Teacher.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
end
