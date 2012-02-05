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
  
  private
  
    def teacher_from_remember_token
      Teacher.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  
end
